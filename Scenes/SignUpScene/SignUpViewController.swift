//
//  SignUpViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.06.2022.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    internal var presenter: SignUpPresenter?
    private let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
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
        setupTextFieldsDelegate()
        setupNavigationBarItem() 

        signInBtn.layer.cornerRadius = 4
        signUpBtn.layer.cornerRadius = 4
        signInBtn.layer.borderWidth = 1

    }

    func setupTextFieldsDelegate() {
        emailTextField.delegate = self
        userNameTextField.delegate = self
        oldPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }

//    @objc func handleDatePicker() {
//        self.birthdayTextField.text = defaultFormatter.string(from: datePicker.date)
//    }
//
//    var defaultFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone.current
//        formatter.dateFormat = "dd.MM.yyyy"
//
//        return formatter
//    }

    private func createDatePicker() {
//        UIDatePicker.appearance().backgroundColor = .blue
//        UIDatePicker.appearance().tintColor = .gray
//        self.datePicker.setValue(UIColor.gray, forKeyPath: "textColor")
//        self.datePicker.datePickerMode = .date
//        self.datePicker.maximumDate = Date()
//        self.datePicker.addTarget(self,
//                                 action: #selector(self.handleDatePicker),
//                                 for: .valueChanged)
//        self.birthdayTextField.inputView = datePicker
//        if #available(iOS 13.4, *) {
//            self.datePicker.preferredDatePickerStyle = .wheels
//        }
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        birthdayTextField.inputView = datePicker
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.datePickerMode = .date
        } else {
            datePicker.datePickerMode = .date
        }
//        datePicker.datePickerMode = .date

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
//            birthdayTextField.text = "\(datePicker.date.formatted(date: .long, time: .omitted))"
            birthdayTextField.text = "\(datePicker.date)"
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
        openSignInScene()
    }
    
    @IBAction func signUpBtnPressed() {
        openMainGalleryScene()
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

        let asterix  = NSMutableAttributedString(string: " *", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])

        userNameTextField.attributedPlaceholder = makeRedStarPlaceholder(left: NSAttributedString(string: "User Name"), right: asterix)
        emailTextField.attributedPlaceholder = makeRedStarPlaceholder(left: NSAttributedString(string: "E-mail"), right: asterix)
        oldPasswordTextField.attributedPlaceholder = makeRedStarPlaceholder(left: NSAttributedString(string: "Old password"), right: asterix)
        confirmPasswordTextField.attributedPlaceholder = makeRedStarPlaceholder(left: NSAttributedString(string: "Confirm password"), right: asterix)
    }

    func makeRedStarPlaceholder(left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
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

extension SignUpViewController: SignUpView {
// TODO: Вынести валидацию в презентер
    func openMainGalleryScene() {
        guard let userName = userNameTextField.text,
              let email = emailTextField.text,
              let password = oldPasswordTextField.text,
              let birthday = birthdayTextField.text,
              let confirmPassword = confirmPasswordTextField.text
        else { return }

        let user = UserEntity(username: userName, email: email, pass: password, birthday: birthday)

        if birthday.isEmpty {
            user.birthday = nil
        }

//        if Validator.isStringValid(stringValue: email, validationType: .email) && Validator.isStringValid(stringValue: password, validationType: .password) &&
        if password == confirmPassword {

            presenter?.registrateAndOpenMainGalleryScene(user: user)
            print("validation OK")

        } else {

            print("validation BAAAAD")
        }
    }

    func openSignInScene() {
        presenter?.openSignInScene()
    }
}
