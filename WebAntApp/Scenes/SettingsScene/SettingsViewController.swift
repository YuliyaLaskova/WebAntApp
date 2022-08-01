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
        let formatter = DateFormatter()
        let humanFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        humanFormatter.dateFormat = "d MMM, yyyy"

        birthdayTextField.text = humanFormatter.string(from: datePicker.date)
//        self.currentDate = formatter.string(from: datePicker.date)
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

    private func dissmissKeyboardIfViewTapped() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))

     }

     @objc func viewTapped() {
         view.endEditing(true)
//         userNameTextField.resignFirstResponder() лучше не использовать ибо тогда надо для каждого поля отдельно прописывать
     }

    @IBAction func deleteAccountBtnPressed() {
    }

    @IBAction func signOutBtnPressed(_ sender: UIButton) {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        appDelegate?.doLogout()

    }

    @objc func saveBtnPressed() {
//        setupModal()
    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingsViewController: SettingsView {

//    func setupInfoModule() {
//        presenter?.showInfoModule()
//    }

    func setupUser(user: UserEntityForGet?) {
        guard let user = presenter?.getCurrentUser() else {
            return
        }
        userNameTextField.text = user.username
        birthdayTextField.text = user.birthday?.convertDateFormatFromISO8601() ?? "no data"
        emailTextField.text = user.email

    }
}
