//
//  MainGalleryCollectionViewExtensions.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 09.08.2022.
//

import Foundation
import UIKit

extension MainGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource  {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0}

        switch newPopularSegmentedControl.selectedIndex {
        case .new: if presenter.newPhotoArray.count > 0 {
            isNeedToShowErrorOnEmptyGallery(false)
            return presenter.newPhotoArray.count
        } else {
            isNeedToShowErrorOnEmptyGallery(true)
            return 0
        }
        case .popular:
            if presenter.popularPhotoArray.count > 0 {
                isNeedToShowErrorOnEmptyGallery(false)
                return presenter.popularPhotoArray.count
            } else {
                isNeedToShowErrorOnEmptyGallery(true)
                return 0
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as? PhotoCell {
            switch newPopularSegmentedControl.selectedIndex {
            case .new:
                guard let photo = presenter?.newPhotoArray[indexPath.row].image?.name else {
                    return UICollectionViewCell()
                }
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 10
                cell.setupImage(photo)
                return cell
            case .popular:
                guard let photo = presenter?.popularPhotoArray[indexPath.row].image?.name else {
                    return UICollectionViewCell()
                }
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 10
                cell.setupImage(photo)
                return cell
            }
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.openDetailedPhoto(photoIndex: indexPath.row, newPopularSegCntrlIndex: newPopularSegmentedControl.selectedIndex)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.presenter!.newPhotoArray.count - 1 {
            self.presenter?.fetchNewPhotosWithPagination(imageName: nil)
        } else if indexPath.row == self.presenter!.popularPhotoArray.count - 1 {
            self.presenter?.fetchPopularPhotosWithPagination(imageName: nil)

        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch newPopularSegmentedControl.selectedIndex {
        case .new:
            presenter?.currentStateOfNewCollection = scrollView.contentOffset.y
        case .popular:
            presenter?.currentStateOfPopularCollection = scrollView.contentOffset.y
        }
    }
}
