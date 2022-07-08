//
//  GetUserUseCase.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 05.07.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol GetUserUseCase {
    func getUserInfo(_ iriId: String) -> Single<UserEntityForGet>
}

class GetUserUseCaseImp: GetUserUseCase {

    let getUserGateway: GetUserGateway

    init(_ gateway: GetUserGateway) {
        self.getUserGateway = gateway
    }

    func getUserInfo(_ iriId: String) -> Single<UserEntityForGet> {
        getUserGateway.getUser(iriId)
    }

}

