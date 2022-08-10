//
//  UserEntity.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 16.06.2022.
//

import Foundation
import RxNetworkApiClient

class UserEntity: JsonBodyConvertible, Codable {

    var username: String
    var birthday: String?
    var email: String
    var password: String

    init(username: String,
         email: String,
         pass: String,
         birthday: String?) {
        self.username = username
        self.email = email
        self.password = pass
        self.birthday = birthday
    }
}

struct EmptyUser: JsonBodyConvertible, Codable {
    var id: Int?
    var username: String?
    var birthday: String?
    var email: String?
    var password: String?
}
