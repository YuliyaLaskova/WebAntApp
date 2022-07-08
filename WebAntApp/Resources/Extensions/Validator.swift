//
//  Validator.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 15.06.2022.
//

import Foundation

enum ValidatorEnum {
    case email
    case password
}

class Validator {

   static func isStringValid(stringValue: String, validationType: ValidatorEnum ) -> Bool {
        var returnValue = true
        var regEx = ""

        switch validationType {
        case .email:
            regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            break
        case .password:
            regEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
            break
        }

        do {
            let regex = try NSRegularExpression(pattern: regEx)
            let nsString = stringValue as NSString
            let results = regex.matches(in: stringValue, range: NSRange(location: 0, length: nsString.length))

            if results.isEmpty {
                print("error in: \(validationType)")
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }

        return  returnValue
    }
}
