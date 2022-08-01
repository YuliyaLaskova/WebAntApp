//
//  AddDataViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class AddDataViewController: ModuleAlertViewController {
    
    internal var presenter: AddDataPresenter?

    @IBOutlet var photoToPost: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
//    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var activityIndicatorView: CustomActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextView.delegate = self

        descriptionTextView.text = "Description"
        descriptionTextView.textColor = .lightGray
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.systemGray6.cgColor
        descriptionTextView.layer.cornerRadius = 5

//        activityIndicator.isHidden = true
//        activityIndicatorView.backgroundColor = .
        activityIndicatorView.isHidden = true

        //        descriptionTextView.adjastableForKeyboard()

        nameTextField.becomeFirstResponder()
        nameTextField.addDoneButtonOnKeyboard()
        descriptionTextView.addDoneButtonOnKeyboard()

        setupBarButtonItems()

        guard let photo = presenter?.takeImageForPost() else {
            return
        }
        photoToPost.image = photo
    }
    
    private func setupBarButtonItems() {

        let addRightBarButtonItem = UIBarButtonItem()
        addRightBarButtonItem.title = "Add"
        addRightBarButtonItem.tintColor = .systemPink
        addRightBarButtonItem.target = self
        addRightBarButtonItem.action = #selector(addBtnPressed)

        navigationItem.rightBarButtonItem = addRightBarButtonItem
        let cancelLeftBarButtonItem = UIBarButtonItem()

        navigationItem.leftBarButtonItem = cancelLeftBarButtonItem
        cancelLeftBarButtonItem.title = "Cancel"
        cancelLeftBarButtonItem.tintColor = .gray
        cancelLeftBarButtonItem.target = self
        cancelLeftBarButtonItem.action = #selector(goBack)

    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc func addBtnPressed() {
        addPressed()
    }
}

// MARK: Extensions

extension AddDataViewController: AddDataView {
    
    func showModalView(finished: @escaping (() -> Void)) {
        showModal(finished: finished)
    }

    func actIndicatorStartAnimating() {
        activityIndicatorView.animate()
        activityIndicatorView.isHidden = false
    }

    func actIndicatorStopAnimating() {
        activityIndicatorView.isHidden = true
        activityIndicatorView = nil
//        activityIndicator.stopAnimating()
//        activityIndicator.isHidden = true
    }

    func addPressed() {
        guard let image = photoToPost.image else {
            return
        }

        var descriptionText = ""
        if descriptionTextView.text == "Description" {
            descriptionText = ""
        } else {
            descriptionText = descriptionTextView.text
        }

        let photo = PhotoEntityForPost(name: nameTextField.text, description: descriptionText, new: true, popular: true, image: nil)

        presenter?.postPhoto(image, photo)
    }
}

extension AddDataViewController: UITextViewDelegate, UITextFieldDelegate{
    // MARK: TextView placeholder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Description"
            textView.textColor = .lightGray
        }
    }
}

// TODO: вынести экстеншн
extension UITextView {
    /**
     Добавляет кнопку "Готово" на клавиатуру
     */
    func addDoneButtonOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self, action: #selector(resignFirstResponder))
        doneButton.tintColor = .gray
        keyboardToolbar.items = [flexibleSpace, doneButton]
        self.inputAccessoryView = keyboardToolbar
    }

    //    func adjastableForKeyboard() {
    //        let notificationCenter = NotificationCenter.default
    //
    //        notificationCenter.addObserver(
    //            self,
    //            selector: #selector(adjustForKeyboard),
    //            name: UIResponder.keyboardWillHideNotification,
    //            object: nil
    //        )
    //        notificationCenter.addObserver(
    //            self,
    //            selector: #selector(adjustForKeyboard),
    //            name: UIResponder.keyboardWillChangeFrameNotification,
    //            object: nil
    //        )
    //    }
    //
    //    @objc private func adjustForKeyboard(notification: Notification) {
    //        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
    //            return
    //        }
    //        let keyboardScreenEndFrame = keyboardValue.cgRectValue
    //        let keyboardViewEndFrame = convert(keyboardScreenEndFrame, from: window)
    //
    //        if notification.name == UIResponder.keyboardWillHideNotification {
    //            contentInset = .zero
    //        } else {
    //            contentInset = UIEdgeInsets(
    //                top: 0,
    //                left: 0,
    //                bottom: keyboardViewEndFrame.height - safeAreaInsets.bottom,
    //                right: 0
    //            )
    //        }
    //
    //        scrollIndicatorInsets = contentInset
    //        scrollRangeToVisible(selectedRange)
    //    }
}
