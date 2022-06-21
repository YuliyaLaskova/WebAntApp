//
//  AuthResponseHandler.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 20.06.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

// Алгоритм работы обработчика ощибок авторизации:
// В первую очередь убеждаемся что пришедшая ошибка связана именно с авторизацией
// и только в этом случае метод в результате работы возвращает true, это означает, что ошибка обработана.
// Далее смотрим текущее состояние токена(tokenState = active по умолчанию):
// 1) active:
// - Если пришел ответ"the access token provided has expired",
//   то меняем состояние токена на неактивно, добавляем метод повторно отправляющий запрос в очереди
//   и делаем запрос на обновление токена, после его успеха повторно выполняем запросы из очереди и очищаем ее,
//   в случае ошибки - делаем logout, состояние меняем на актив и отправляем эту ошибку во все observer-ы из очереди ;
// - Если ответ связан с попыткой залогиниться мапим в соответствущую ошибку и отправляем в ObserverType
// - В остальных случаях
// 2) refreshing:
// - Если исходный запрос не является запросом на обновление токена - он добавляется в очередь
// - Если это был запрос на обновление токена и вернулась ошибка связанная с авторизацией - значит
//   обновить токен не удалось: делаем logout
// 3) при остальных состояниях токена если ошибка связана с авторизацией отправляем ошибку в обзервер иначе возвращаем false

open class AuthResponseHandler: ResponseHandler {

    private let jsonDecoder = JSONDecoder()
    private let authUseCase: SignInUseCaseImp
    private var settings: Settings
    private let apiClient: ApiClient
    private weak var delegate: AuthResponseHandlerDelegate?

    // Вместо BaseApp вставить имя проекта
    private let queue = DispatchQueue(label: "ru.WebAnt.BaseApp.Queue.AuthResponseHandler")
    // swiftlint:disable line_length
    private let timerQueue = SerialDispatchQueueScheduler(internalSerialQueueName: "ru.WebAnt.BaseApp.Queue.AuthResponseHandler.RxTimer")
    // swiftlint:disable line_length
    private let refreshTokenQuery = ("grant_type", "refresh_token")

    private var _tokenState: TokenState = .active
    private var tokenState: TokenState {
        get {
            queue.sync { self._tokenState }
        }
        set {
            queue.sync { self._tokenState = newValue }
            print("#token state changed to: \(String(describing: newValue))")
        }
    }

    private var _pendingRequestsBlocks = [(Error?) -> Void]()
    private var pendingRequestsBlocks: [(Error?) -> Void] {
        get {
            queue.sync { self._pendingRequestsBlocks }
        }
        set {
            queue.sync { self._pendingRequestsBlocks = newValue }
        }
    }

    private let disposeBag = DisposeBag()

    private var lastRefreshTokenTime = Date(timeIntervalSince1970: 0)

    init(_ delegate: AuthResponseHandlerDelegate,
         _ authUseCase: SignInUseCaseImp,
         _ settings: Settings,
         _ apiClient: ApiClient) {
        self.delegate = delegate
        self.authUseCase = authUseCase
        self.settings = settings
        self.apiClient = apiClient
    }

    // swiftlint:disable function_body_length
    public func handle<T: Codable>(observer: @escaping SingleObserver<T>,
                                   request: ApiRequest<T>,
                                   response: NetworkResponse) -> Bool {
        if let data = response.data,
           let responseError = try? jsonDecoder.decode(AuthErrorResponseEntity.self, from: data) {
            let error = responseError.error_description.lowercased()
            if self.tokenState == .active {
                switch error {
                case let message where message.contains("invalid grant_type parameter or parameter missing"):
                    observer(.failure(AuthResponseHandlerError.errorApplication))
                    return true

                case let message where message.contains("the client credentials are invalid") ||
                        message.contains("the grant type is unauthorized for this client_id"):
                    observer(.failure(AuthResponseHandlerError.invalidClient))
                    return true

                case let message where message.contains("missing parameters. \"username\" and \"password\" required"):
                    observer(.failure(AuthResponseHandlerError.missingParameters))
                    return true

                case let message where message.contains("invalid username and password combination"):
                    observer(.failure(AuthResponseHandlerError.invalidCombination))
                    return true

                case let message where message.contains("invalid refresh token"):
                    observer(.failure(AuthResponseHandlerError.invalidRefreshToken))
                    return true

                case let message where message.contains("the access token provided has expired"):
                    self.pendingRequestsBlocks.append { responseError in
                        if responseError == nil {
                            _ = self.apiClient.execute(request: request).subscribe(observer)
                        } else {
                            observer(.failure(responseError ?? UserError(message: "Undefined error")))
                        }
                    }
                    refreshToken(request: request, observer: observer)
                    return true

                case let message where message.contains("refresh token has expired") ||
                    message.contains("user account is disabled") ||
                    message.contains("the access token provided is invalid") ||
                    message.contains("oauth2 authentication required"):
                    observer(.failure(AuthResponseHandlerError.requiredReAuthentication))
                    delegate?.doLogout()
                    return true

                default:
                    break
                }
            } else if self.tokenState == .refreshing {
                let wasRequestTokenRefresh = request.formData?.contains(where: { $0.0 == refreshTokenQuery.0 && ($0.1 as? String) == refreshTokenQuery.1 }) ?? false
                if wasRequestTokenRefresh {
                    // запрос на рефреш завершился ошибкой
                    let responseError = AuthResponseHandlerError.requiredReAuthentication
                    observer(.failure(responseError))
                    delegate?.doLogout()
                    self.tokenState = .active
                    self.processPendingRequests(with: responseError)
                } else {
                    self.pendingRequestsBlocks.append { responseError in
                        if responseError == nil {
                            _ = self.apiClient.execute(request: request).subscribe(observer)
                        } else {
                            observer(.failure(responseError ?? UserError(message: "Undefined error")))
                        }
                    }
                }
                return true
            } else {
                let isErrorRelatedToAuth = [
                    "token",
                    "expired",
                    "invalid",
                    "grant_type"
                ]
                    .map(error.contains)
                    .contains(true)
                if isErrorRelatedToAuth {
                    observer(.failure(AuthResponseHandlerError.invalidRefreshToken))
                    return true
                } else {
                    return false
                }
            }
        }
        return false
    }
    // swiftlint:enable function_body_length

    private func refreshToken<T: Codable>(request: ApiRequest<T>, observer: @escaping SingleObserver<T>) {
        self.tokenState = .refreshing
        authUseCase.refreshToken()
            .catch({ error -> Completable in
                if error is AuthResponseHandlerError {
                    return .error(error)
                } else {
                    return self.authUseCase.refreshToken()
                        .delaySubscription(.seconds(1), scheduler: self.timerQueue)
                }
            })
            .subscribe(onCompleted: { [weak self] in
                self?.tokenState = .active
                self?.processPendingRequests()
            }, onError: { error in
                print("## failed to refresh token: \(error)")
            })
            .disposed(by: disposeBag)
    }

    private func processPendingRequests(with error: Error? = nil) {
        let requestsToExecute = self.pendingRequestsBlocks.map({ $0 })
        self.pendingRequestsBlocks.removeAll()
        requestsToExecute.forEach({ $0(error) })
    }
}

protocol AuthResponseHandlerDelegate: AnyObject {

    func doLogout()
}

enum AuthResponseHandlerError: LocalizedError {

    case requiredReAuthentication
    case errorApplication
    case invalidClient
    case missingParameters
    case invalidCombination

    case invalidRefreshToken

    case codeNotFound
    case codeTimeOut

}

class AuthErrorResponseEntity: LocalizedError, Codable {

    var error: String
    var error_description: String

    public var errorDescription: String? {
        error_description
    }

    init(error: String, error_description: String) {
        self.error = error
        self.error_description = error_description
    }
}

class ErrorMessageResponseEntity: Codable {

    let message: String?
}

class ErrorMessageLOLResponseEntity: Codable {

    let ms: String?
}
// swiftlint:enable identifier_name

struct UserError: LocalizedError {

    let message: String

    var errorDescription: String? {
        self.message
    }
}

class ErrorResponseEntity: LocalizedError, Codable {
    var title: String
    var detail: String
    var violations: [ViolationEntity]?

    init(title: String, detail: String, violations: [ViolationEntity]?) {
        self.title = title
        self.detail = detail
        self.violations = violations
    }
}

class ViolationEntity: Codable {

    var propertyPath: String?
    var message: String?

    var localizePropertyPath: String {
        switch self.propertyPath {

                case "email":
                    return "R.string.errorEntities.violationEntityEmail()"

                case "name":
                    return "R.string.errorEntities.violationEntityName()"

                default:
                    return self.propertyPath ?? ""
                }
        }
}
