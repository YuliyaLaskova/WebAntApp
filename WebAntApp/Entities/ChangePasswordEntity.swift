//
//  ChangePasswordEntity.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 01.08.2022.
//

import Foundation
import RxNetworkApiClient

class ChangePasswordEntity: JsonBodyConvertible, Codable {
    var oldPassword: String
    var newPassword: String

    init(oldPassword: String, newPassword: String) {
        self.oldPassword = oldPassword
        self.newPassword = newPassword
    }
}
