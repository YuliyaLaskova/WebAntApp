//
//  SettingsViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit
//import MaterialTextField

class SettingsViewController: UIViewController {
    
    var presenter: SettingsPresenter?

    @IBOutlet var userPhotoView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var userNameTextField: DesignableUITextField!
    @IBOutlet var birthdayTextField: DesignableUITextField!
    @IBOutlet var emailTextField: DesignableUITextField!
    @IBOutlet var oldPasswordTextField: DesignableUITextField!
    @IBOutlet var newPasswordTextField: DesignableUITextField!
    @IBOutlet var confirmPasswordTextField: DesignableUITextField!

    @IBOutlet var deleteAccountButton: UIButton!
    @IBOutlet var signOutButton: UIButton!
    let datePicker = UIDatePicker()
    public let passwordLength = 6

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTextFields()
        setDatePicker()

        userPhotoView.layer.borderWidth = 1
        userPhotoView.layer.borderColor = UIColor.systemGray5.cgColor
        userPhotoView.layer.cornerRadius = 50
//        tabBarController?.tabBar.isHidden = true
        presenter?.viewDidLoad()

        // TODO: кнопку return на клаве поменять на кнопку готово и затем скрывать клавиатуру
        dissmissKeyboardIfViewTapped()
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

    private func setupNavigationBar() {
        let saveRightBarButtonItem = UIBarButtonItem()
        saveRightBarButtonItem.title = "Save"
        saveRightBarButtonItem.tintColor = .systemPink
        saveRightBarButtonItem.target = self
        saveRightBarButtonItem.action = #selector(saveBtnPressed)

        navigationItem.rightBarButtonItem = saveRightBarButtonItem

        let cancelLeftBarButtonItem = UIBarButtonItem()
        cancelLeftBarButtonItem.title = "Cancel"
        cancelLeftBarButtonItem.tintColor = .gray
        cancelLeftBarButtonItem.target = self
        cancelLeftBarButtonItem.action = #selector(goBack)

        navigationItem.leftBarButtonItem = cancelLeftBarButtonItem
    }

    private func setupTextFields() {

        guard let userIconImage = UIImage(resource: R.image.userIcon) else { return }
        userNameTextField.rightImage = userIconImage

        guard let calendarIconImage = UIImage(resource: R.image.calendarIcon) else { return }
        birthdayTextField.rightImage = calendarIconImage

        guard let emailIconImage = UIImage(resource: R.image.emailIcon) else { return }
        emailTextField.rightImage = emailIconImage

        oldPasswordTextField.rightButton = UIButton()
        newPasswordTextField.rightButton = UIButton()
        confirmPasswordTextField.rightButton = UIButton()

        oldPasswordTextField.isSecureTextEntry = true
        newPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func dissmissKeyboardIfViewTapped() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))

     }

     @objc func viewTapped() {
         view.endEditing(true)
     }

    @IBAction func deleteAccountBtnPressed() {
        presenter?.deleteUserAccount()
    }

    @IBAction func signOutBtnPressed(_ sender: UIButton) {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        appDelegate?.doLogout()

    }

    @objc func saveBtnPressed() {
//        checkPasswordTextFieldsAndUpdateData()
        checkUserTextFieldsAndUpdateData()

    }

//    private func checkPasswordTextFieldsAndUpdateData() {
//        if (newPasswordTextField.text == confirmPasswordTextField.text) {
//            guard let oldPassword = oldPasswordTextField.text,
//                  let newPassword = newPasswordTextField.text else {
//                return
//            }
//            presenter?.changeUserPassword(oldPassword: oldPassword, newPassword: newPassword)
//        }
//    }

    // TODO: доделай сюда модалку об ошибке
}

extension SettingsViewController {
     func showAlert(withTitle: String, andMessage: String) {
        let alertController = UIAlertController(title: title, message: andMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: R.string.scenes.okAction(), style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
