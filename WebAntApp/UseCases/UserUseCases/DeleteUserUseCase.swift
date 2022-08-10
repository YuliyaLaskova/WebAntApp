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
    func deleteUser(userId: Int) -> Completable
}

class DeleteUserUseCasImp: DeleteUserUseCase {
    private let deleteUserGateway: DeleteUserGateway
    var settings: Settings

    init(_ settings: Settings, _ gateway: DeleteUserGateway) {
        self.settings = settings
        self.deleteUserGateway = gateway
    }

    func deleteUser(userId: Int) -> Completable {
        return self.deleteUserGateway.deleteAccount(userId)
            .observe(on:MainScheduler.instance)
            .do(onSuccess: { [weak self] user in
                self?.settings.clearUserData()
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
