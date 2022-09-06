//
//  ChangeUserInfoUseCase.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 02.08.2022.
//

import Foundation
import RxSwift

protocol ChangeUserInfoUseCase {
    func updateUserInfo(_ userId: Int?, _ entity: UserEntity) -> Completable
}

class ChangeUserInfoUseCaseImp: ChangeUserInfoUseCase {

    private let changeUserInfoGateway: ChangeUserInfoGateway

    init(_ gateway: ChangeUserInfoGateway) {
        self.changeUserInfoGateway = gateway
    }

    func updateUserInfo(_ userId: Int?, _ entity: UserEntity) -> Completable {
        guard let userId = userId else {
            return .error(UserUseCaseError.localUserIdIsNil)
        }
        return self.changeUserInfoGateway.updateUserInfo(userId, entity)
    }
}
