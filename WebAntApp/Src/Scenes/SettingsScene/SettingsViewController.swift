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

    @IBOutlet var userPhoto: UIImageView!
    @IBOutlet var deleteAccountButton: UIButton!
    @IBOutlet var signOutButton: UIButton!
    let datePicker = UIDatePicker()
    let imagePicker = UIImagePickerController()
    public let passwordLength = 6

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTextFields()
        setDatePicker()

        userPhotoView.layer.borderWidth = 1
        userPhotoView.layer.borderColor = UIColor.systemGray5.cgColor
        userPhotoView.layer.cornerRadius = 50
        userPhoto.layer.cornerRadius = 50

//        tabBarController?.tabBar.isHidden = true
        presenter?.viewDidLoad()
        dissmissKeyboardIfViewTapped()
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        userPhoto.isUserInteractionEnabled = true
        tapObserver()
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
        self.setTabBarHidden(true)
        self.setupLeftNavigationBarButton(title: "Cancel", selector: #selector(goBack))

        let saveRightBarButtonItem = UIBarButtonItem()
        saveRightBarButtonItem.title = "Save"
        saveRightBarButtonItem.tintColor = .systemPink
        saveRightBarButtonItem.target = self
        saveRightBarButtonItem.action = #selector(saveBtnPressed)

        navigationItem.rightBarButtonItem = saveRightBarButtonItem
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

        birthdayTextField.addDoneButtonOnKeyboard()
    }

    @objc func goBack() {
        self.setTabBarHidden(false)
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
        checkUserTextFieldsAndUpdateData()
    }
    
    private func tapObserver() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapImage)
        )
        userPhoto.addGestureRecognizer(tapGesture)
    }

    @objc func didTapImage() {
        let alert = UIAlertController(title: "Choose the source", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
