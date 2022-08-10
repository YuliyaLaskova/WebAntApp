//
//  ChangeUserInfoGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 02.08.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol ChangeUserInfoGateway{
    func updateUserInfo(_ userId: Int, _ entity: UserEntity) -> Completable
}

class ChangeUserInfoGatewayImp: ApiBaseGateway, ChangeUserInfoGateway {
    func updateUserInfo(_ userId: Int, _ entity: UserEntity) -> Completable {
        let request: ApiRequest<UserEntity> = ExtendedApiRequest.updateUserInfoRequest(userId: userId, user: entity)
            return apiClient.execute(request: request)
            .asCompletable()
    }
}
