//
//  EnumErrorForUserUseCase.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 17.08.2022.
//

import Foundation

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

enum RequestError: Error {
    case selfIsNil

    var errorDescription: String? {
        switch self {
        case .selfIsNil:
            return R.string.scenes.selfIsNil()
        }
    }
}
