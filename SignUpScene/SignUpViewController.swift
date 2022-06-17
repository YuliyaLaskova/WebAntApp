//
//  SignUpViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.06.2022.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    internal var presenter: SignUpPresenter?
    private let datePicker = UIDatePicker()
    
    // MARK: IB Outlets

    @IBOutlet var userNameTextField: DesignableUITextField!
    @IBOutlet var birthdayTextField: DesignableUITextField!
    @IBOutlet var emailTextField: DesignableUITextField!
    @IBOutlet var oldPasswordTextField: DesignableUITextField!
    @IBOutlet var confirmPasswordTextField: DesignableUITextField!

    @IBOutlet var signInBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: Setup UI method

    private func setupUI() {

        setupIconsInTextFields()
        createDatePicker()

        signInBtn.layer.cornerRadius = 4
        signUpBtn.layer.cornerRadius = 4
        signUpBtn.layer.borderWidth = 1

    }

    func setupTextFieldsDelegate() {
        emailTextField.delegate = self
        userNameTextField.delegate = self
        oldPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }

    private func createDatePicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        birthdayTextField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date

        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: nil,
            action: #selector (dateDoneBtnPressed)
        )

        let cancelButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: nil,
            action: #selector (dateCancelBtnPressed)
        )

        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil, action: nil)

        toolbar.setItems([cancelButton, flexibleSpace,doneButton], animated: true)

        birthdayTextField.inputAccessoryView = toolbar
    }

    @objc func dateDoneBtnPressed() {
        if birthdayTextField.text?.isEmpty == true {
            birthdayTextField.resignFirstResponder()
            birthdayTextField.text = "\(datePicker.date.formatted(date: .long, time: .omitted))"
        } else {
            birthdayTextField.text = ""
            birthdayTextField.resignFirstResponder()
        }
    }

    @objc func dateCancelBtnPressed() {
        birthdayTextField.text = .none
        birthdayTextField.resignFirstResponder()
    }


    // MARK: IB Actions

    @IBAction func signInBtnPressed() {
        signInBtnTapped()
    }
    
    @IBAction func signUpBtnPressed() {
        signUpBtnPressed()
    }


    // MARK: Setup Icons In Text Fields method

    private func setupIconsInTextFields() {

        guard let userIconImage = UIImage(resource: R.image.userIcon) else { return }
        userNameTextField.rightImage = userIconImage

        guard let calendarIconImage = UIImage(resource: R.image.calendarIcon) else { return }
        birthdayTextField.rightImage = calendarIconImage

        guard let emailIconImage = UIImage(resource: R.image.emailIcon) else { return }
        emailTextField.rightImage = emailIconImage

        oldPasswordTextField.rightButton = UIButton()
        confirmPasswordTextField.rightButton = UIButton()

    }
}

extension SignUpViewController: SignUpView {
    func signUpBtnPressed(user: UserEntity) {
        presenter?.signUpBtnPressed(user: user)
    }

    func signInBtnTapped() {
        presenter?.signInBtnPressed()
    }
}
