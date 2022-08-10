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
    var presenter: AddDataPresenter?

    @IBOutlet var photoToPost: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!

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
        //        activityIndicatorView.isHidden = true

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
    func startActivityIndicator() {
        addActivityInd(isNeeded: true ,superView: self.view)
    }

    func stopActivityIndicator() {
        addActivityInd(isNeeded: false ,superView: self.view)
    }

    //    func actIndicatorStartAnimating() {
    ////        activityIndicatorView.animate()
    ////        activityIndicatorView.isHidden = false
    //    }
    //
    //    func actIndicatorStopAnimating() {
    ////        activityIndicatorView.isHidden = true
    ////        activityIndicatorView = nil
    ////        activityIndicator.stopAnimating()
    ////        activityIndicator.isHidden = true
    //    }

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
