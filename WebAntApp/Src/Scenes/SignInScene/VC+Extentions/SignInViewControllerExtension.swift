//
//  SignInViewControllerExtension.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 09.08.2022.
//

import Foundation
import UIKit

extension SignInViewController: UITextFieldDelegate {
    func setupTextFieldsDelegate() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text?.removingWhitespaces()
    }
}

extension SignInViewController: SignInView {
    func startActivityIndicator() {
        setupActivityIndicator()
    }

    func stopActivityIndicator() {
        removeActivityIndicator()
    }

    func openSignUpScene() {
        presenter?.openSignUpScene()
    }
}

