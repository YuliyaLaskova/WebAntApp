//
//  AddDataExtensions.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 12.08.2022.
//

import Foundation
import UIKit

extension AddDataViewController: AddDataView {

    func showModalView(finished: @escaping (() -> Void)) {
        showModel(finished: finished)
    }
    func startActivityIndicator() {
        setupActivityIndicator()    }

    func stopActivityIndicator() {
        removeActivityIndicator()    }

    func validateFieldsAndProceed() {
        view.endEditing(true)
        guard let image = photoToPost.image else {
            return
        }

        var descriptionText = ""
        if descriptionTextView.text.removingWhitespaces().isEmpty {
            addInfoModuleWithFunc(alertTitle: R.string.scenes.error(), alertMessage: "Description couldn't consist only of whitespaces", buttonMessage: R.string.scenes.okAction())
            return
        }
        else  if descriptionTextView.text == "Description" {
            descriptionText = ""
        } else {
            descriptionText = descriptionTextView.text
        }

        guard let name = nameTextField.text,
              name.removingWhitespaces() != ""
            else { return addInfoModuleWithFunc(alertTitle: R.string.scenes.error(), alertMessage: "Name couldn't be empty", buttonMessage: R.string.scenes.okAction())
        }

        let photo = PhotoEntityForPost(name: name, description: descriptionText, new: true, popular: true, image: nil)

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
