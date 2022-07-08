//
//  GetCurrentUserUseCase.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.07.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol GetCurrentUserUseCase {
    func getCurrentUser() -> Single<UserEntityForGet>
}

class GetCurrentUserUseCaseImp: GetCurrentUserUseCase {
    let getCurrentUserGateway: GetCurrentUserGateway

    init(_ gateway: GetCurrentUserGateway) {
        self.getCurrentUserGateway = gateway
    }

    func getCurrentUser() -> Single<UserEntityForGet> {
        getCurrentUserGateway.getCurrentUser()
    }
}

