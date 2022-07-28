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

    @IBOutlet var userNameTextField: DesignableUITextField!
    @IBOutlet var birthdayTextField: DesignableUITextField!
    @IBOutlet var emailTextField: DesignableUITextField!
    @IBOutlet var oldPasswordTextField: DesignableUITextField!
    @IBOutlet var newPasswordTextField: DesignableUITextField!
    @IBOutlet var confirmPasswordTextField: DesignableUITextField!

    @IBOutlet var deleteAccountButton: UIButton!
    @IBOutlet var signOutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavogationBar()
        setupUI()

        userPhotoView.layer.borderWidth = 1
        userPhotoView.layer.borderColor = UIColor.systemGray5.cgColor
        userPhotoView.layer.cornerRadius = 50
//        tabBarController?.tabBar.isHidden = true

        // TODO: кнопку return на клаве поменять на кнопку готово и затем скрывать клавиатуру
        dissmissKeyboardIfViewTapped()
    }

    private func setupNavogationBar() {
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

    private func setupUI() {


//        userNameTextField.delegate = self
//        emailTextField.delegate = self
//        birthdayTextField.delegate = self
//        oldPasswordTextField.delegate = self
//        confirmPasswordTextField.delegate = self

        guard let userIconImage = UIImage(resource: R.image.userIcon) else { return }
        userNameTextField.rightImage = userIconImage

        guard let calendarIconImage = UIImage(resource: R.image.calendarIcon) else { return }
        birthdayTextField.rightImage = calendarIconImage

        guard let emailIconImage = UIImage(resource: R.image.emailIcon) else { return }
        emailTextField.rightImage = emailIconImage

        oldPasswordTextField.rightButton = UIButton()
        confirmPasswordTextField.rightButton = UIButton()


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

    @IBAction func signOutBtnPressed(_ sender: Any) {
    }

    @objc func saveBtnPressed() {

    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingsViewController: SettingsView {
    
}

extension SettingsViewController: UITextFieldDelegate  {

}
