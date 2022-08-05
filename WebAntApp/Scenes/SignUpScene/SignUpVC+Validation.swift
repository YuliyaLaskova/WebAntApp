//
//  SignUpVC+Validation.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 04.08.2022.
//

import Foundation

extension SignUpViewController {
    
    func  validateTextFieldsAndProceed() {
        var errors: [Error] = []
        var password = "",
            confirmPassword = ""
//        let entity: UserEntity

        guard let userName = userNameTextField.text,
              let email = emailTextField.text,
              let userPassword = oldPasswordTextField.text,
              let birthday = birthdayTextField.text//,
//              let userConfirmPassword = confirmPasswordTextField.text
        else { return }

        let entity = UserEntity(username: userName, email: email, pass: userPassword, birthday: birthday)

        do {
            entity.username = try self.validateName()
            print("имя норм")
            // вызывать функцию из дезайнблтекстфилд об ошибке
        } catch let error {
            // вызывать функцию из дезайнблтекстфилд об ошибке
            print("проблема в имени")
            errors.append(error)
        }

        do {
            entity.email = try self.validateEmail()
            print("емейл норм")
            // вызывать функцию из дезайнблтекстфилд об ошибке
            //            self.emailTextField.setError(nil, animated: true)
        } catch let error {
            print("проблема в емейле")
            //            self.emailTextField.setError(error, animated: true)
            errors.append(error)
        }

        do {
            entity.birthday = try self.validateDateOfBirth()
            print("ДР норм")
            // вызывать функцию из дезайнблтекстфилд об ошибке
        } catch let error {
            print("проблема в ДР")
            // вызывать функцию из дезайнблтекстфилд об ошибке
            errors.append(error)
        }

        do {
            password = try self.validatePassword(self.oldPasswordTextField) ?? ""
            print("пароль норм")
//            self.passwordTextField.setError(nil, animated: true)
        } catch let error {
            print("проблема в пароле")
//            self.passwordTextField.setError(error, animated: true)
            errors.append(error)
        }
        do {
            confirmPassword = try self.validatePassword(self.confirmPasswordTextField) ?? ""
//            self.confirmPasswordTextfield.setError(nil, animated: true)
        } catch let error {
//            self.confirmPasswordTextfield.setError(error, animated: true)
            errors.append(error)
        }
        if password != confirmPassword {
            let message = TextFieldsError.passwordsAreDifferent.localizedDescription
            self.showAlert(withTitle: "Error", andMessage: message)
            return
        }
        entity.password = password

        guard errors.isEmpty else {
            let message = R.string.scenes.pleaseCheckYourData()
            self.showAlert(withTitle: "Error", andMessage: message)
            return
        }

        self.presenter?.registrateAndOpenMainGalleryScene(user: entity)

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

