//
//  DeleteUserGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 09.08.2022.
//
import Foundation
import RxSwift
import RxNetworkApiClient

protocol DeleteUserGateway {
    func deleteAccount(_ userId: Int) -> Single<UserEntityForGet>
}

class DeleteUserGatewayImp: ApiBaseGateway, DeleteUserGateway {
    func deleteAccount(_ userId: Int) -> Single<UserEntityForGet> {
            return apiClient.execute(request: ExtendedApiRequest.deleteUserRequest(userId: userId))
    }
}
