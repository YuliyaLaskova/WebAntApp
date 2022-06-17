//
//  UserEntity.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 16.06.2022.
//

import Foundation
import RxNetworkApiClient

class UserEntity: JsonBodyConvertible, Codable {

    var username: String?
    var birthday: String?
    var email: String?
    var password: String?

    init(username: String?,
         email: String?,
         pass: String?,
         birthday: String?) {
        self.username = username
        self.email = email
        self.password = pass
        self.birthday = birthday
    }
//
//    init(user: SignUpEntity) {
//        self.firstName = user.firstName
//        self.middleName = user.middleName
//        self.lastName = user.lastName
//        self.email = user.email
//        self.phone = user.phone
//        self.plainPassword = user.plainPassword
//        self.isAgreementAccepted = user.isAgreementAccepted
//        self.dateOfBirth = user.dateOfBirth
//        self.roles = []
//    }
}
