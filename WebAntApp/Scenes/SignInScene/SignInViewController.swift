//
//  SignInController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.06.2022.
//

import UIKit

class SignInViewController: UIViewController {
    var presenter: SignInPresenter?
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
        setupTextFieldsDelegate()
        signInBtn.layer.cornerRadius = 4
        signUpBtn.layer.cornerRadius = 4
        signUpBtn.layer.borderWidth = 1

        setupNavigationBarItem()

        guard let emailIconImage = UIImage(resource: R.image.emailIcon) else { return }
        emailTextField.rightImage = emailIconImage

        passwordTextField.rightButton = UIButton()
    }
    // MARK: IB Actions

    @IBAction func signInBtnPressed() {
        if isFieldEmpty() {
            self.addInfoModuleWithFunc(
                alertTitle: R.string.scenes.error(),
                alertMessage: R.string.scenes.emptyFieldsMessage(),
                buttonMessage: R.string.scenes.okAction(),
                completion: nil
            )
        }
        signInAndOpenMainGallery()
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

    @IBAction func signUpBtnPressed() {
        openSignUpScene()
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
