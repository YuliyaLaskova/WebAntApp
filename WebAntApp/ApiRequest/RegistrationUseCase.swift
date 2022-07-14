//
//  RegistrationUseCase.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 14.06.2022.
//

import Foundation
import RxSwift

protocol RegistrationUseCase {
    func signUp(login: String, password: String) -> Single<User>
}

class RegistrationUseCaseImp: RegistrationUseCase {
    let registrationGateway: RegistrationGateway

    init (gateway: RegistrationGateway) {
        self.registrationGateway = gateway
    }

    func signUp(login: String, password: String) -> Single<User> {
        return self.registrationGateway.signIn(login: login, password: password)
    }
}
