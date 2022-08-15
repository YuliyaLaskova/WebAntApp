//
//  MainGalleryView.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 21.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

protocol MainGalleryView: BaseView {
    func refreshPhotoCollection()
    func endRefreshing()
    func actIndicatorStartAnimating()
    func actIndicatorStopAnimating()
    func showErrorOnEmptyGallery(show: Bool)
    func startActivityIndicator()
    func stopActivityIndicator()
}
