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
import UIKit

protocol MainGalleryPresenter {
    var isNewsLoadingInProgress: Bool { get }

    var newPhotoArray: [PhotoEntityForGet] { get set }
    var popularPhotoArray: [PhotoEntityForGet] { get set }
    var currentStateOfNewCollection: CGFloat { get set }
    var currentStateOfPopularCollection: CGFloat { get set }
    func fetchNewPhotosWithPagination(imageName: String?)
    func fetchPopularPhotosWithPagination(imageName: String?)
    func subscribeOnNewPhotoUpdates()
    func subscribeOnPopularPhotoUpdates()
    func openDetailedPhoto(photoIndex: Int, newPopularSegCntrlIndex: Int)
    func refreshPhotos(photoIndex: Int, needToLoadPhotos: Bool)
    func viewDidLoad()
}
