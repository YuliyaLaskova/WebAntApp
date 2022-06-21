//
//  Settings.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 20.06.2022.
//

import Foundation

protocol Settings: AnyObject {

    var token: Token? { get set }

    func clearUserData()
}


class LocalSettings: Settings {
    func clearUserData() {
        self.token = nil
        //               self.account = nil
        self.userDefaults.resetUserDefaults()

    }


    private let userDefaults: UserDefaultsSettings

    init(userDefaults: UserDefaultsSettings) {
        self.userDefaults = userDefaults
    }


    var token: Token? {
        get {
            self.userDefaults.read(UserDefaultsKey.token)
        }
        set(value) {
            self.userDefaults.saveData(UserDefaultsKey.token, value)
        }
    }
    
}
