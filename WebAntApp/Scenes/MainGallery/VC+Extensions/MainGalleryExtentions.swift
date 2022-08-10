//
//  MainGalleryExtentions.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 09.08.2022.
//

import Foundation
import UIKit

extension MainGalleryViewController: MainGalleryView {
    func showErrorOnEmptyGallery(show: Bool) {
        switch show {
        case true:
            errorImage.isHidden = false
        default:
            errorImage.isHidden = true
        }
    }

    func refreshPhotoCollection() {
        imageCollection.reloadData()
    }

    func actIndicatorStartAnimating() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func actIndicatorStopAnimating() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}

extension MainGalleryViewController: CustomSegmentedControlDelegate  {
    func change(to index: Int) {
        searchBar.text = ""
        switch index {
        case 0:
            imageCollection.setContentOffset(CGPoint(x: 0, y: presenter?.currentStateOfNewCollection ?? 0), animated: false)
            presenter?.fetchNewPhotosWithPagination(imageName: nil)
        case 1:
            imageCollection.setContentOffset(CGPoint(x: 0, y: presenter?.currentStateOfPopularCollection ?? 0), animated: false)
            presenter?.fetchPopularPhotosWithPagination(imageName: nil)
        default:
            break
        }
        refreshPhotoCollection()
    }
}
