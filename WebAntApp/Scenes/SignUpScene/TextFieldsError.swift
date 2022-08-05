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
            return R.string.scenes.emptyFieldsMessage()
        case .incorrectEmail:
            return R.string.scenes.incorrect()
        case .nameFieldIsEmpty:
            return R.string.scenes.emptyFieldsMessage()
        case .dateOfBirthIsEmpty:
            return R.string.scenes.emptyFieldsMessage()
        case .passwordFieldIsTooShort(let length):
            return R.string.scenes.fieldIsTooShort(String(length), "6")
        case .forbiddenSymbols:
            return R.string.scenes.forbiddenSymbolsForPassword("Password")
        case .passwordsAreDifferent:
            return R.string.scenes.passwordsAreDifferent()
        }
    }
}
