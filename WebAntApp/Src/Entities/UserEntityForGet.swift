//
//  UserEntityForGet.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 05.07.2022.
//

import Foundation
import RxNetworkApiClient

class UserEntityForGet: JsonBodyConvertible, Codable {

    var username: String
    var birthday: String?
    var email: String
    var id: Int

    init(username: String,
         email: String,
         id: Int,
         birthday: String?) {
        self.username = username
        self.email = email
        self.id = id
        self.birthday = birthday
    }
}

