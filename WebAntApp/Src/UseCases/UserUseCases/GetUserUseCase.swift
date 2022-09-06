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
    var settings: Settings

    init(_ gateway: GetUserGateway, _ settings: Settings) {
        self.getUserGateway = gateway
        self.settings = settings
    }

    func getUserInfo(_ iriId: String) -> Single<UserEntityForGet> {
        getUserGateway.getUser(iriId)
            .observe(on: MainScheduler.instance)
            .do(onSuccess: { [weak self] user in
                self?.settings.account = user
            })
    }

}

