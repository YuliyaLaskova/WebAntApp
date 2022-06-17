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

}

class SignInUseCaseImp: SignInUseCase {

    private var signInGateway: SignInGateway

    init(signInGateway: SignInGateway) {
        self.signInGateway = signInGateway
    }

    func signIn(_ login: String, _ password: String) -> Completable {
        signInGateway.authorize(login: login, password: password)
            .do { token in
                            print(token)
                        }
                         onError: { error in
                            print(error)
                        } onSubscribe: {
                            print("Subscribe")
                        }
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
