////
////  SignInUseCase.swift
////  WebAntApp
////
////  Created by Yuliya Laskova on 15.06.2022.
////

import Foundation
import RxSwift

enum TokenState {

    case active
    case refreshing
    case failedToRefresh
    case none
}

protocol SignInUseCase {

    func signIn(_ login: String, _ password: String) -> Completable
    func refreshToken() -> Completable

}

class SignInUseCaseImp: SignInUseCase {

    private var signInGateway: SignInGateway
    private var settings: Settings
    var tokenState: TokenState

    var tokenCondition: TokenState {
        tokenState
    }


    init(signInGateway: SignInGateway, settings: Settings) {
        self.signInGateway = signInGateway
        self.settings = settings
//        self.tokenState = tokenState
        self.tokenState = settings.token == nil ? .none : .active
    }

    func signIn(_ login: String, _ password: String) -> Completable {
        signInGateway.authorize(login: login, password: password)
            .do { token in
                print("@@@token:\naccess:\(token.access_token)")
                self.settings.token = token
                self.tokenState = .active
            }

    onError: { error in
        print(error)
    }
    .asCompletable()
    }
    
    func refreshToken() -> Completable {
        let refToken = settings.token?.refresh_token ?? ""
        return signInGateway.refreshToken(refreshToken: refToken)
            .observe(on: MainScheduler.instance)
            .do(onSuccess: { tokenEntity in
                self.settings.token = tokenEntity
                self.tokenState = .active
            }, onError: { _ in
                self.tokenState = .failedToRefresh
            }, onSubscribe: {
                self.tokenState = .refreshing
            }, onDispose: {
                if self.tokenState == .refreshing {
                    self.tokenState = .failedToRefresh
                }
            })
                .asCompletable()
                }

}

enum LoginError: LocalizedError {
    case notAvailableRole

    var errorDescription: String? {
        switch self {
        case .notAvailableRole:
            return "Incorrect user role."
        }
    }
}
