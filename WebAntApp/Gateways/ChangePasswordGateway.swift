//
//  ChangePasswordGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 01.08.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol ChangePasswordGateway {
    func updateUserPassword(_ userId: Int, _ entity: ChangePasswordEntity) -> Completable
}

class ChangePasswordGatewayImp: ApiBaseGateway, ChangePasswordGateway {
    func updateUserPassword(_ userId: Int, _ entity: ChangePasswordEntity) -> Completable {
        let request: ApiRequest<ChangePasswordEntity> = ExtendedApiRequest.updatePassword(userId: userId, passwordEntity: entity)
            return apiClient.execute(request: request)
            .asCompletable()
        }
}

