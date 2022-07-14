//
//  SignUpGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 17.06.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol SignUpGateway {

    func signUp(_ entity: UserEntity) -> Single<UserEntity>
}

class SignUpGatewayImp: ApiBaseGateway, SignUpGateway {

    func signUp(_ entity: UserEntity) -> Single<UserEntity> {
        let request: ExtendedApiRequest<UserEntity> = ExtendedApiRequest.signUpRequest(userEntity: entity)
        return apiClient.execute(request: request)
    }
}
