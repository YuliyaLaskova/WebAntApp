//
//  SettingsVC+Validation.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.08.2022.
//

import Foundation
import UIKit

extension SettingsViewController {

    func checkUserTextFieldsAndUpdateData() {
        var errors: [Error] = []
        var newPassword = "",
            oldPassword = "",
            confirmPassword = ""

        guard let userName = userNameTextField.text,
              let email = emailTextField.text,
              let userPassword = oldPasswordTextField.text,
              let birthday = birthdayTextField.text
        else { return }

        let entity = UserEntity(username: userName, email: email, pass: userPassword, birthday: birthday)

        do {
            entity.username = try self.validateName()
            print("имя норм")
            userNameTextField.addErrorLabelToTextField(needToShowLabel: false, withText: nil, superView: self.view)
        } catch let error {
            userNameTextField.addErrorLabelToTextField(needToShowLabel: true, withText: error.localizedDescription, superView: self.view)
            print("проблема в имени")
            errors.append(error)
        }

        do {
            entity.email = try self.validateEmail()
            print("емейл норм")
            emailTextField.addErrorLabelToTextField(needToShowLabel: false, withText: nil, superView: self.view)
        } catch let error {
            print("проблема в емейле")
            emailTextField.addErrorLabelToTextField(needToShowLabel: true, withText: error.localizedDescription, superView: self.view)
            errors.append(error)
        }

        do {
            if birthdayTextField.text == "" {
                entity.birthday = nil
            } else {
            entity.birthday = try self.validateDateOfBirth()
                print("ДР норм")
            }
        } catch let error {
            errors.append(error)
        }

        do {
            oldPassword = try self.validatePassword(self.oldPasswordTextField) ?? ""
            print("пароль норм")
            oldPasswordTextField.addErrorLabelToTextField(needToShowLabel: false, withText: nil, superView: self.view)
        } catch let error {
            print("проблема в пароле")
            oldPasswordTextField.addErrorLabelToTextField(needToShowLabel: true, withText: error.localizedDescription, superView: self.view)
            errors.append(error)
        }
        do {
            newPassword = try self.validatePassword(self.oldPasswordTextField) ?? ""
            print("пароль норм")
            newPasswordTextField.addErrorLabelToTextField(needToShowLabel: false, withText: nil, superView: self.view)
        } catch let error {
            print("проблема в пароле")
            newPasswordTextField.addErrorLabelToTextField(needToShowLabel: true, withText: error.localizedDescription, superView: self.view)
            errors.append(error)
        }
        do {
            confirmPassword = try self.validatePassword(self.confirmPasswordTextField) ?? ""
            confirmPasswordTextField.addErrorLabelToTextField(needToShowLabel: false, withText: nil, superView: self.view)

        } catch let error {
            confirmPasswordTextField.addErrorLabelToTextField(needToShowLabel: true, withText: error.localizedDescription, superView: self.view)
            errors.append(error)
        }

        if newPassword != confirmPassword {
            let message = TextFieldsError.passwordsAreDifferent.localizedDescription
            self.showAlert(withTitle: R.string.scenes.error(), andMessage: message)
            return
        }

        entity.password = newPassword

        guard errors.isEmpty else {
            let message = R.string.scenes.pleaseCheckYourData()
            self.showAlert(withTitle: R.string.scenes.error(), andMessage: message)
            return
        }

        if (newPasswordTextField.text == confirmPasswordTextField.text) {
            guard let oldPassword = oldPasswordTextField.text,
                  let newPassword = newPasswordTextField.text else {
                return
            }
            presenter?.changeUserPassword(oldPassword: oldPassword, newPassword: newPassword)
        }

        presenter?.changeUserInfo()
        self.navigationController?.reloadInputViews()

    }

    func validateEmail() throws -> String {
        var email: String?
        email = self.emailTextField.text
        guard let validEmail = email,
              !validEmail.isEmpty else {
            throw TextFieldsError.emailFieldIsEmpty
        }
        guard validEmail.isValidEmail else {
            throw TextFieldsError.incorrectEmail
        }
        return validEmail
    }

    func validateName() throws -> String {
        var error: TextFieldsError?

        error = TextFieldsError.nameFieldIsEmpty

        guard let name = self.userNameTextField.text,
              !name.isEmpty
        else {
            throw error!
        }

        return name
    }

    func validateDateOfBirth() throws -> String {
        guard let dateOfBirth = self.birthdayTextField.text,
              dateOfBirth.removingWhitespaces() != "" else {
            throw TextFieldsError.dateOfBirthIsEmpty
        }

        return DateFormatter.defaultFormatter.string(from: datePicker.date)
    }

    func validatePassword(_ textfield: DesignableUITextField) throws -> String? {
        guard let password = textfield.text,
              password.removingWhitespaces() != "",
              password.removingWhitespaces().count >= self.passwordLength else {
            throw TextFieldsError.passwordFieldIsTooShort(length: self.passwordLength)
        }
        guard password.isValidPassword else {
            throw TextFieldsError.forbiddenSymbols
        }
        return password
    }
}
