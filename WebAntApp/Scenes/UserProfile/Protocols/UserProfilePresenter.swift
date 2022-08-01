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
    var isPhotoLoadingInProgress: Bool { get }
    
    func getCurrentUserFromAPI()
    func fetchUserPhotos()
    func viewDidLoad()
    func refreshPhotos(photoIndex: Int)
    func getCurrentUser() -> UserEntityForGet?
    func openDetailedPhoto(photoIndex: Int)
    func goToSettingScene()

}
