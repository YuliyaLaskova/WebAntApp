//
//  MainGalleryPresenter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 21.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

protocol MainGalleryPresenter {
    var isNewsLoadingInProgress: Bool { get }

//    var photoItems: [PhotoEntityForGet] { get set }
    var newPhotoArray: [PhotoEntityForGet] { get set }
    var popularPhotoArray: [PhotoEntityForGet] { get set }
    
//    func fetchPhotos()
    func fetchNewPhotosWithPagination()
    func fetchPopularPhotosWithPagination()
    func subscribeOnNewPhotoUpdates()
    func subscribeOnPopularPhotoUpdates()
    func openDetailedPhoto(photoIndex: Int, newPopularSegCntrlIndex: Int)
    func refreshPhotos(photoIndex: Int)
    func viewDidLoad()
}
