//
//  UserDefaultsKeyType.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 20.06.2022.
//

import Foundation

protocol UserDefaultsKeyType {

    var rawValue: String { get }
}

enum UserDefaultsKey: String, CaseIterable, UserDefaultsKeyType {

    case token
    case account

    static var clearable: [UserDefaultsKey] {
        UserDefaultsKey.allCases
    }
}
