//
//  SignUpViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.06.2022.
//

import UIKit

class SignUpViewController: UIViewController {

    internal var presenter: SignUpPresenter?
    
    // MARK: IB Outlets

    @IBOutlet var userNameTextField: DesignableUITextField!
    @IBOutlet var birthdayTextField: DesignableUITextField!
    @IBOutlet var emailTextField: DesignableUITextField!
    @IBOutlet var oldPasswordTextField: DesignableUITextField!
    @IBOutlet var confirmPasswordTextField: DesignableUITextField!

    @IBOutlet var userIconImageView: UIImageView!
    @IBOutlet var calendarIconImageView: UIImageView!
    @IBOutlet var emailIconImageView: UIImageView!
    @IBOutlet var eyeIconImageView: UIImageView!

    @IBOutlet var signInBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: Setup UI method

    private func setupUI() {

        setupIconsInTextFields()

        signInBtn.layer.cornerRadius = 4
        signUpBtn.layer.cornerRadius = 4
        signUpBtn.layer.borderWidth = 1

    }

    // MARK: IB Actions

    @IBAction func signInBtnPressed() {
    }
    
    @IBAction func signUpBtnPressed() {
    }


    // MARK: Setup Icons In Text Fields method

    private func setupIconsInTextFields() {
        userIconImageView = UIImageView(image: UIImage(named: "userIcon.png"))
        userIconImageView.contentMode = UIView.ContentMode.center
        userIconImageView.frame = CGRect(x: 0.0, y: 0.0, width: userIconImageView.image!.size.width + 20, height: userIconImageView.image!.size.height)
        userNameTextField.rightViewMode = UITextField.ViewMode.always
        userNameTextField.rightView = userIconImageView

        calendarIconImageView = UIImageView(image: UIImage(named: "calendarIcon.png"))
        calendarIconImageView.contentMode = UIView.ContentMode.center
        calendarIconImageView.frame = CGRect(x: 0.0, y: 0.0, width: calendarIconImageView.image!.size.width + 20, height: calendarIconImageView.image!.size.height)
        birthdayTextField.rightViewMode = UITextField.ViewMode.always
        birthdayTextField.rightView = calendarIconImageView

        emailIconImageView = UIImageView(image: UIImage(named: "emailIcon.png"))
        emailIconImageView.contentMode = UIView.ContentMode.center
        emailIconImageView.frame = CGRect(x: 0.0, y: 0.0, width: emailIconImageView.image!.size.width + 20, height: emailIconImageView.image!.size.height)
        emailTextField.rightViewMode = UITextField.ViewMode.always
        emailTextField.rightView = emailIconImageView

        eyeIconImageView = UIImageView(image: UIImage(named: "eyeIcon.png"))
        eyeIconImageView.contentMode = UIView.ContentMode.center
        eyeIconImageView.frame = CGRect(x: 0.0, y: 0.0, width: eyeIconImageView.image!.size.width + 20, height: eyeIconImageView.image!.size.height)
        oldPasswordTextField.rightViewMode = UITextField.ViewMode.always
        oldPasswordTextField.rightView = eyeIconImageView

        eyeIconImageView = UIImageView(image: UIImage(named: "eyeIcon.png"))
        eyeIconImageView.contentMode = UIView.ContentMode.center
        eyeIconImageView.frame = CGRect(x: 0.0, y: 0.0, width: eyeIconImageView.image!.size.width + 20, height: eyeIconImageView.image!.size.height)
        confirmPasswordTextField.rightViewMode = UITextField.ViewMode.always
        confirmPasswordTextField.rightView = eyeIconImageView
    }

}

extension SignUpViewController: SignUpView {

}
