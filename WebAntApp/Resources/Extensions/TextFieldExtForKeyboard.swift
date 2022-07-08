//
//  TextFieldExtForKeyboard.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 06.07.2022.
//

import Foundation

import UIKit

extension UITextField {
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
}
