//
//  SignInVC+Validation.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 12.08.2022.
//

import Foundation
import UIKit

extension SignInViewController {

    func validateTextFieldsAndProceed() {
        var errors: [Error] = []

        guard let userName = loginTextField.text,
              let userPassword = passwordTextField.text
        else { return }

        let entity = UserEntity(username: userName, email: "", pass: userPassword, birthday: nil)

        do {
            entity.username = try self.validateName()
            loginTextField.addErrorLabelToTextField(needToShowLabel: false, withText: nil, superView: self.view)
        } catch let error {
            loginTextField.addErrorLabelToTextField(needToShowLabel: true, withText: error.localizedDescription, superView: self.view)
            errors.append(error)
        }

        do {
            _ = try self.validatePassword(self.passwordTextField) ?? ""
            passwordTextField.addErrorLabelToTextField(needToShowLabel: false, withText: nil, superView: self.view)
        } catch let error {
            passwordTextField.addErrorLabelToTextField(needToShowLabel: true, withText: error.localizedDescription, superView: self.view)
            errors.append(error)
        }

        guard errors.isEmpty else {
            self.addInfoModuleWithFunc(
                alertTitle: R.string.scenes.error(),
                alertMessage: R.string.scenes.pleaseCheckYourData(),
                buttonMessage: R.string.scenes.okAction()
            )
            return
        }

        self.presenter?.signInAndOpenMainGallery(username: userName, password: userPassword)
    }

        func validateName() throws -> String {
            var error: TextFieldsError?

            error = TextFieldsError.nameFieldIsEmpty
            guard let name = self.loginTextField.text,
                  !name.isEmpty
            else {
                throw error!
            }
            return name
        }

        func validatePassword(_ textfield: DesignableUITextField) throws -> String? {
            guard let password = textfield.text,
                  password.removingWhitespaces() != ""
            else { throw TextFieldsError.passwordFieldIsTooShort(length: 6)
            }
            guard password.isValidPassword else {
                throw TextFieldsError.forbiddenSymbols
            }
            return password
        }
    }
