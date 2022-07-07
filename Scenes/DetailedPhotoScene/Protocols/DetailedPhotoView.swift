//
//  DetailedPhotoView.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 01.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

protocol DetailedPhotoView: AnyObject {
    func setView(image: String?,
                 name: String?,
                 desription: String?,
                 user: String?)

    func getUsername(username: String?)
}
