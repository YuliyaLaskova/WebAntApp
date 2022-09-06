//
//  SignUpViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.06.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    var presenter: SignUpPresenter?
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var currentDate: String?
    public let passwordLength = 6
    
    // MARK: IB Outlets
    @IBOutlet var label: UILabel!
    @IBOutlet var testViewWithLabel: UIView!
    @IBOutlet var signInBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet var userNameTextField: DesignableUITextField!
    @IBOutlet var birthdayTextField: DesignableUITextField!
    @IBOutlet var emailTextField: DesignableUITextField!
    @IBOutlet var oldPasswordTextField: DesignableUITextField!
    @IBOutlet var confirmPasswordTextField: DesignableUITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupLeftNavigationBarButton(title: R.string.scenes.cancel(), selector: #selector(goBack))
    }
    
    // MARK: Setup UI method

    private func setupUI() {
        setupIconsInTextFields()
        setDatePicker()
        setupTextFields()

        signInBtn.layer.cornerRadius = 4
        signUpBtn.layer.cornerRadius = 4
        signInBtn.layer.borderWidth = 1
    }

    func setupTextFields() {
        userNameTextField.delegate = self
        emailTextField.delegate = self
        birthdayTextField.delegate = self
        oldPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self

        birthdayTextField.addDoneButtonOnKeyboard()
    }

    func setDatePicker() {
        birthdayTextField.inputView = datePicker
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.datePickerMode = .date
        } else {
            datePicker.datePickerMode = .date
        }
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapped = UITapGestureRecognizer(target: self, action: #selector(closeDataPicker))
        self.view.addGestureRecognizer(tapped)
        let maxData = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        datePicker.maximumDate = maxData
    }

    @objc func dateChanged() {
        getDateFromPicker()
    }

    func getDateFromPicker() {
        birthdayTextField.text = DateFormatter.defaultFormatter.string(from: datePicker.date)
    }

    @objc func closeDataPicker() {
        view.endEditing(true)
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
        view.endEditing(true)
        self.validateTextFieldsAndProceed()
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

        userNameTextField.attributedPlaceholder = makeRedStarPlaceholder(left: NSAttributedString(string: R.string.scenes.username()), right: asterix)
        emailTextField.attributedPlaceholder = makeRedStarPlaceholder(left: NSAttributedString(string: R.string.scenes.email()), right: asterix)
        oldPasswordTextField.attributedPlaceholder = makeRedStarPlaceholder(left: NSAttributedString(string: R.string.scenes.password()), right: asterix)
        confirmPasswordTextField.attributedPlaceholder = makeRedStarPlaceholder(left: NSAttributedString(string: R.string.scenes.confirmPassword()), right: asterix)
    }

    func makeRedStarPlaceholder(left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

