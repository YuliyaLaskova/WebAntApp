//
//  SettingsPresenter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

protocol SettingsPresenter {
    func getCurrentUser() -> UserEntityForGet?
    func getCurrentUserFromAPI()
    func viewDidLoad()
    func changeUserPassword(oldPassword: String, newPassword: String)
    func changeUserInfo()
    func deleteUserAccount()
}
