//
//  DeleteUserUseCase.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 09.08.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol DeleteUserUseCase {
    func deleteUser() -> Completable
}

class DeleteUserUseCasImp: DeleteUserUseCase {
    private let deleteUserGateway: DeleteUserGateway
    var settings: Settings
    private var user: UserEntityForGet?

    init(_ settings: Settings, _ gateway: DeleteUserGateway) {
        self.settings = settings
        self.deleteUserGateway = gateway
    }

    func deleteUser() -> Completable {
//        guard let userId = settings.account?.id else {
//            return .error(UserUseCaseError.localUserIdIsNil)
//        }
        guard let userId = user?.id else {
            return .error(UserUseCaseError.localUserIdIsNil)}
        return self.deleteUserGateway.deleteAccount(userId)
            .observe(on:MainScheduler.instance)
            .do(onSuccess: { [weak self] user in
                self?.settings.clearUserData()
//                self?.settings.account = nil
//                self?.settings.token = nil
            },
            onError: { error in
                // TODO: модалка об ошибке
                print("delete error")
            })
            .asCompletable()
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

//func updatePassword(_ userId: Int?, _ entity: ChangePasswordEntity) -> Completable {
//    guard let userId = userId else {
//        return .error(UserUseCaseError.localUserIdIsNil)
//    }
//    return self.changePasswordGateway.updateUserPassword(userId, entity)
//}
//guard let userId = settings.account?.id else {
//return .error(UserUseCaseError.localUserIdIsNil)
