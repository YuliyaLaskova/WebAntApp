//
//  ChangePasswordUseCase.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 01.08.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol ChangePasswordUseCase {
    func updatePassword(_ userId: Int?, _ entity: ChangePasswordEntity) -> Completable
}

class ChangePasswordUseCaseImp: ChangePasswordUseCase {

    private let changePasswordGateway: ChangePasswordGateway

    init(_ gateway: ChangePasswordGateway) {
        self.changePasswordGateway = gateway
    }

    func updatePassword(_ userId: Int?, _ entity: ChangePasswordEntity) -> Completable {
        guard let userId = userId else {
            return .error(UserUseCaseError.localUserIdIsNil)
        }
        return self.changePasswordGateway.updateUserPassword(userId, entity)
    }

    enum UserUseCaseError: LocalizedError {
        case localUserIdIsNil
        case remoteUserIdIsNil

        var errorDescription: String? {
            switch self {
            case .localUserIdIsNil:
                return R.string.scenes.localUserIdIsNil()

            case .remoteUserIdIsNil:
                return R.string.scenes.remoteUserIdIsNil()
            }
        }
    }
}
