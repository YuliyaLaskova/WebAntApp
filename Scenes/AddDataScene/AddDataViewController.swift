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

class AddDataViewController: UIViewController, UITextViewDelegate {
    
    internal var presenter: AddDataPresenter?

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


        nameTextField.becomeFirstResponder()

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

// MARK: Extensions

extension AddDataViewController: AddDataView {
    func addPressed() {
        guard let image = photoToPost.image else {
            return
        }
        let photo = PhotoEntityForPost(name: nameTextField.text, description: descriptionTextView.text, new: true, popular: true, image: nil)

        presenter?.postPhoto(image, photo)
    }
}
