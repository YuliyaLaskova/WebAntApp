//
//  SignUpUseCase.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 16.06.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient


protocol SignUpUseCase {
    func signUp(_ entity: UserEntity) -> Single<UserEntity>
}

class SignUpUseCaseImp: SignUpUseCase {
    let registrationGateway: SignUpGateway

    init(_ gateway: SignUpGateway) {
        self.registrationGateway = gateway
    }

    func signUp(_ entity: UserEntity) -> Single<UserEntity> {
        return self.registrationGateway.signUp(entity)
    }
}
