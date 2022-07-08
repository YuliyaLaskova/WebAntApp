//
//  UserProfilePresenter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import RxSwift

protocol UserProfilePresenter {
    var photoItems: [PhotoEntityForGet] { get set }
    func getCurrentUserFromAPI()
    func fetchUserPhotos()

    func getCurrentUser() -> UserEntityForGet?
}
