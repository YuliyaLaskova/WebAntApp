//
//  SignUpExtensions.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 09.08.2022.
//

import Foundation
import UIKit

extension SignUpViewController: SignUpView {
    func startActivityIndicator() {
        setupActivityIndicator()
        
    }
    
    func stopActivityIndicator() {
        removeActivityIndicator()
    }
    
    func openSignInScene() {
        presenter?.openSignInScene()
    }
}

extension SignUpViewController {
    func showAlert(withTitle: String, andMessage: String) {
        let alertController = UIAlertController(title: title, message: andMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: R.string.scenes.okAction(), style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Work with keyboard

extension SignUpViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            birthdayTextField.becomeFirstResponder()
        } else if textField == birthdayTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            oldPasswordTextField.becomeFirstResponder()
        }  else if textField == oldPasswordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else if textField == confirmPasswordTextField {
            view.endEditing(true)
        }
        return true
    }
}
