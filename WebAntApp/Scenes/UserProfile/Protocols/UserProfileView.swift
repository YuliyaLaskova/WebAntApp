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

protocol UserProfileView: AnyObject {

    func setupUser(user: UserEntityForGet?)

    func refreshPhotoCollection()
    func endRefreshing()
    func actIndicatorStartAnimating()
    func actIndicatorStopAnimating()
    func showErrorOnEmptyGallery(show: Bool)
}
