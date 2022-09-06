//
//  UserProfileView.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

protocol UserProfileView: BaseView {

    func setupUser(user: UserEntityForGet?)
    func refreshPhotoCollection()
    func endRefreshing()
    func startActivityIndicator()
    func stopActivityIndicator()
    func showErrorOnEmptyGallery(show: Bool)
    func openSettingsScene()
}
