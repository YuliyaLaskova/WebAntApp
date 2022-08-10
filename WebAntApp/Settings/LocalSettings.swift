//
//  Settings.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 20.06.2022.
//

import Foundation

protocol Settings: AnyObject {

    var token: Token? { get set }
    var account: UserEntityForGet? { get set }
    
    func clearUserData()
}


class LocalSettings: Settings {

//    var account: UserEntityForGet?
    var token: Token? {
        get {
            if
                let accessToken = UserDefaults.standard.object(forKey: "accessToken") as? String,
                let refreshToken = UserDefaults.standard.object(forKey: "refreshToken") as? String
            {
                let token = Token(accessToken: accessToken, refreshToken: refreshToken)
                return token
            } else {
                return nil
            }
            //  self.userDefaults.read(UserDefaultsKey.token)
        }
        set(value) {
            guard let newToken = value else {
                return
            }
            UserDefaults.standard.set(newToken.access_token, forKey: "accessToken")
            UserDefaults.standard.set(newToken.refresh_token, forKey: "refreshToken")
        }
    }

    var userDefaults: UserDefaultsSettings?

    var account: UserEntityForGet? {
        get {
        if
            let acc = UserDefaults.standard.object(forKey: "id") as? Int
//            let refreshToken = UserDefaults.standard.object(forKey: "refreshToken") as? String
        {
            let account = UserEntityForGet(username: "", email: "", id: acc, birthday: "")
            return account
        } else {
            return nil
        }
    }
        set(value) {
            guard let acc = value else {
                return
            }
            UserDefaults.standard.set(acc.id, forKey: "id")
        }
    }


    func clearUserData() {
        self.token = nil
        self.account = nil
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
    }



//    init(userDefaults: UserDefaultsSettings) {
//        self.userDefaults = userDefaults
//    }
    
}
