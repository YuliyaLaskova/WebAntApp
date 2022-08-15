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
    private let signInGateway: SignInGateway
    private let settings: Settings
    private var tokenState: TokenState
    private let currentUserGateway: GetCurrentUserGateway

    var tokenCondition: TokenState {
        tokenState
    }
    var account: UserEntityForGet? {
        get {
            settings.account
        }
        set(acc) {
            settings.account = acc
        }
    }

    init(signInGateway: SignInGateway, settings: Settings, currentUserGateway: GetCurrentUserGateway) {
        self.signInGateway = signInGateway
        self.settings = settings
        self.currentUserGateway = currentUserGateway
        self.tokenState = settings.token == nil ? .none : .active
    }

    func signIn(_ login: String, _ password: String) -> Completable {
        signInGateway.authorize(login: login, password: password)
            .do(onSuccess: { tokenEntity in
                self.settings.token = tokenEntity
                self.tokenState = .active
            }, onSubscribe: {
                self.settings.token = nil
                self.tokenState = .none
            })
                .asCompletable()
                .andThen(self.currentUserGateway.getCurrentUser())
                .asCompletable()
                .do(onCompleted: {
                    NotificationCenter.default.post(name: .onUserSignedIn, object: nil)
                })

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

extension Notification.Name {
    static let onUserSignedIn = Notification.Name("onUserSignedIn")
}
