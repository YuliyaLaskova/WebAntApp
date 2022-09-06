//
//  SettingsVC+Extentions.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.08.2022.
//

import Foundation
import UIKit

extension SettingsViewController: SettingsView {
    func startActivityIndicator() {
        setupActivityIndicator()
    }

    func stopActivityIndicator() {
        removeActivityIndicator()
    }

    func setupUser(user: UserEntityForGet?) {
        guard let user = presenter?.getCurrentUser() else {
            return
        }
        userNameTextField.text = user.username
        birthdayTextField.text = user.birthday?.convertDateFormatFromISO8601() ?? "no data"
        emailTextField.text = user.email
    }
}
