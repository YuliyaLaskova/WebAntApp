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

protocol DetailedPhotoView: BaseView {
    func setView(image: String?,
                 name: String?,
                 desription: String?,
                 user: String?,
                 dateCreation: String?)

    func getUsername(username: String?)
//    func startActivityIndicator(at view: UIViewController)
//    func stopActivityIndicator(at view: UIViewController)
    func startActivityIndicator()
    func stopActivityIndicator()
}
