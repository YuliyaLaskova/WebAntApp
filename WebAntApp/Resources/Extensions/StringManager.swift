//
//  StringManager.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 15.06.2022.
//

import Foundation

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func convertDateFormatFromISO8601() -> String {
            print(self)

            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            if let oldDate = formatter.date(from: self) {
                let convertDateFormatter = DateFormatter()
                convertDateFormatter.dateFormat = "dd.MM.yyyy"

                return convertDateFormatter.string(from: oldDate)
            } else {
                return ""
            }
        }

    var isValidEmail: Bool {
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
 
    var isValidPassword: Bool {
        return CharacterSet.passwordAllowedSet
            .isSuperset(of: CharacterSet(charactersIn: self))
    }
}
