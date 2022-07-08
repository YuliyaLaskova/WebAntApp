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
    // это пример использования в коде
    // №1
    //    let lsettings = LocalSettings()
    //    lsettings.clearUserData()
    // №2
    //    LocalSettings().clearUserData()
}


class LocalSettings: Settings {
    func clearUserData() {
        self.token = nil
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
    }

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
    
}
