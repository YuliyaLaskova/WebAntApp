//
//  DetailedPhotoPresenter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 01.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

protocol DetailedPhotoPresenter {
    func setImage()
    func getPhotoModel() -> PhotoEntityForGet?
    func getUserInfo(_ iriId: String)
    
}
