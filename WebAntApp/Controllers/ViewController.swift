//
//  ViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 06.06.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: IB Outlets

    @IBOutlet var createAccountBtn: UIButton!
    @IBOutlet var haveAccountBtn: UIButton!
    @IBOutlet var logoView: UIImageView!

    @IBOutlet var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet var createAccountBtnTopCnstr: NSLayoutConstraint!
    @IBOutlet var haveAccountBtnTopCnstr: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: Constraints

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.orientation.isPortrait {
            logoTopConstraint.constant = 208
            createAccountBtnTopCnstr.constant = 40
            haveAccountBtnTopCnstr.constant = 10

            view.layoutIfNeeded()
        }

        else if UIDevice.current.orientation.isLandscape {
            logoTopConstraint.constant = 20
            createAccountBtnTopCnstr.constant = 20
            haveAccountBtnTopCnstr.constant = 20
//            haveAccountBtn.titleLabel?.font = UIFont(name: "System Bold", size: 10)
            view.layoutIfNeeded()
        }
    }

    // MARK: Setup UI method

    private func setupUI() {
        createAccountBtn.layer.cornerRadius = 4
        haveAccountBtn.layer.cornerRadius = 4
        haveAccountBtn.layer.borderWidth = 1

    }

    // MARK: IB Actions

    @IBAction func createAccountBtnPressed() {
    }

    @IBAction func haveAccountBtnPressed() {
    }

}

//import UIKit
//
//class SignInController: UIViewController {
//
//    // MARK: IB Outlets
//
//    @IBOutlet var signInBtn: UIButton!
//    @IBOutlet var signUpBtn: UIButton!
//    @IBOutlet var emailTextField: DesignableUITextField!
//    @IBOutlet var passwordTextField: DesignableUITextField!
//    @IBOutlet var emailIconImageView: UIImageView!
//    @IBOutlet var eyeIconImageView: UIImageView!
//
//    @IBOutlet var signInLabelTopCnstr: NSLayoutConstraint!
//    @IBOutlet var loginStackTopCnstr: NSLayoutConstraint!
//    @IBOutlet var signInUpStackTopCnstr: NSLayoutConstraint!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//
//    // MARK: IB Actions
//
//    @IBAction func signInBtnPressed() {
//    }
//
//    @IBAction func signUpBtnPressed() {
//    }
//
//    // MARK: Constraints
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        if UIDevice.current.orientation.isPortrait {
//            signInLabelTopCnstr.constant = 140
//            loginStackTopCnstr.constant = 50
//            signInUpStackTopCnstr.constant = 50
//
//            view.layoutIfNeeded()
//        }
//
//        else if UIDevice.current.orientation.isLandscape {
//            signInLabelTopCnstr.constant = 50
//            loginStackTopCnstr.constant = 20
//            signInUpStackTopCnstr.constant = 20
//            view.layoutIfNeeded()
//        }
//    }
//
//    // MARK: Setup UI method
//
//    private func setupUI() {
//        signInBtn.layer.cornerRadius = 4
//        signUpBtn.layer.cornerRadius = 4
//        signUpBtn.layer.borderWidth = 1
//
//        emailTextField.becomeFirstResponder()
//
//        emailIconImageView = UIImageView(image: UIImage(named: "emailIcon.png"))
//        emailIconImageView.contentMode = UIView.ContentMode.center
//        emailIconImageView.frame = CGRect(x: 0.0, y: 0.0, width: emailIconImageView.image!.size.width + 20, height: emailIconImageView.image!.size.height)
//        emailTextField.rightViewMode = UITextField.ViewMode.always
//        emailTextField.rightView = emailIconImageView
//
//        eyeIconImageView = UIImageView(image: UIImage(named: "eyeIcon.png"))
//        eyeIconImageView.contentMode = UIView.ContentMode.center
//        eyeIconImageView.frame = CGRect(x: 0.0, y: 0.0, width: eyeIconImageView.image!.size.width + 20, height: eyeIconImageView.image!.size.height)
//        passwordTextField.rightViewMode = UITextField.ViewMode.always
//        passwordTextField.rightView = eyeIconImageView
//
//    }
//}
//
//    // MARK: - Work with keyboard
//
//extension SignInController: UITextFieldDelegate {
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        view.endEditing(true)
//    }
//}

//import UIKit
//
//class SignUpController: UIViewController {
//
//    @IBOutlet var scrollView: UIScrollView!
//    @IBOutlet var signInLabel: UIStackView!
//    @IBOutlet var userInformationStack: UIStackView!
//    @IBOutlet var signInUpStack: UIStackView!
//
//    @IBOutlet var userNameTextField: DesignableUITextField!
//    @IBOutlet var userBirthdayTextField: DesignableUITextField!
//    @IBOutlet var userEmailTextField: DesignableUITextField!
//    @IBOutlet var oldPasswordTextField: DesignableUITextField!
//    @IBOutlet var confirmPasswordTextField: DesignableUITextField!
//
//    @IBOutlet var signInBtn: UIButton!
//    @IBOutlet var signUpBtn: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//
//    @IBAction func signInBtnPressed() {
//    }
//
//    @IBAction func signUpBtnPressed() {
//    }
//
//}
