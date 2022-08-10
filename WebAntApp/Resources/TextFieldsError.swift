//
//  TextFieldsError.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 04.08.2022.
//

import Foundation

enum TextFieldsError: LocalizedError, Equatable {
    case emailFieldIsEmpty
    case incorrectEmail
    case nameFieldIsEmpty
    case dateOfBirthIsEmpty
    case passwordFieldIsTooShort(length: Int)
    case forbiddenSymbols
    case passwordsAreDifferent

    var errorDescription: String? {
        switch self {
        case .emailFieldIsEmpty:
            return R.string.scenes.fieldIsEmptyEng("E-mail")
        case .incorrectEmail:
            return R.string.scenes.incorrectEng()
        case .nameFieldIsEmpty:
            return R.string.scenes.fieldIsEmptyEng("User Name")
        case .dateOfBirthIsEmpty:
            return R.string.scenes.emptyFieldsMessage()
        case .passwordFieldIsTooShort(let length):
            return R.string.scenes.fieldIsTooShortEng("Password", String(length))
        case .forbiddenSymbols:
            return R.string.scenes.forbiddenSymbolsForPasswordEng("Password")
        case .passwordsAreDifferent:
            return R.string.scenes.passwordsAreDifferentEng()
        }
    }
}
