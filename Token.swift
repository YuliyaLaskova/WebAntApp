//
//  Token.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 15.06.2022.
//

import Foundation

class Token: Codable {
    
    var access_token: String
    var refresh_token: String

    init(accessToken: String, refreshToken: String) {
        self.access_token = accessToken
        self.refresh_token = refreshToken
    }
}
