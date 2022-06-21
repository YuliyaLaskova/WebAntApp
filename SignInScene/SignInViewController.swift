//
//  SignInController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.06.2022.
//

import UIKit

class SignInViewController: UIViewController {
    
    internal var presenter: SignInPresenter?
    
    // MARK: IB Outlets

    @IBOutlet var signInBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet var emailTextField: DesignableUITextField!
    @IBOutlet var passwordTextField: DesignableUITextField!
    
    @IBOutlet var signInLabelTopCnstr: NSLayoutConstraint!
    @IBOutlet var loginStackTopCnstr: NSLayoutConstraint!
    @IBOutlet var signInUpStackTopCnstr: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: IB Actions

    @IBAction func signInBtnPressed() {
        if isFieldEmpty() {
            showAlert(with: "Error", and: "You didn't fill all fields")
        }
        signInBtnTapped()
    }

    @IBAction func signUpBtnPressed() {
        signUpBtnTapped()
    }

    // MARK: Constraints

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.orientation.isPortrait {
            signInLabelTopCnstr.constant = 140
            loginStackTopCnstr.constant = 50
            signInUpStackTopCnstr.constant = 50

            view.layoutIfNeeded()
        }

        else if UIDevice.current.orientation.isLandscape {
            signInLabelTopCnstr.constant = 50
            loginStackTopCnstr.constant = 20
            signInUpStackTopCnstr.constant = 20
            view.layoutIfNeeded()
        }
    }

    // MARK: Setup UI method

    private func setupUI() {
        signInBtn.layer.cornerRadius = 4
        signUpBtn.layer.cornerRadius = 4
        signUpBtn.layer.borderWidth = 1

        setupNavigationBarItem()

        guard let emailIconImage = UIImage(resource: R.image.emailIcon) else { return }
        emailTextField.rightImage = emailIconImage

        passwordTextField.rightButton = UIButton()

    }

    func setupNavigationBarItem() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let cancelButton = UIBarButtonItem.init(
              title: "Cancel",
              style: .done,
              target: self,
            action: #selector(goBack)
        )
        self.navigationItem.leftBarButtonItem = cancelButton
        cancelButton.tintColor = .gray
    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - Work with keyboard

extension SignInViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            signInBtnPressed()
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text?.removingWhitespaces()
    }
}

// MARK: Validation extension

extension SignInViewController: SignInView {

    func signUpBtnTapped() {
        presenter?.signUpBtnPressed()
    }

    func signInBtnTapped() {

        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }

        if Validator.isStringValid(stringValue: email, validationType: .email) && Validator.isStringValid(stringValue: password, validationType: .password) {
            presenter?.signInBtnPressed(username: email, password: password)
            print("validation OK")
        } else {
            print("validation BAAAAD")
        }
    }
}

// MARK: alert extension

extension SignInViewController {
    private func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func isFieldEmpty() -> Bool {
        var isEmailTTextEmpty: Bool {
            emailTextField.text == ""
        }
        var isPasswordTitleEmpty: Bool {
            passwordTextField.text == ""
        }
        return isEmailTTextEmpty || isPasswordTitleEmpty
    }
}
