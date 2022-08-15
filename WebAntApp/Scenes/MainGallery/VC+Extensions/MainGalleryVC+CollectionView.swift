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

        switch newPopularSegCntrl.selectedIndex {
        case 0: if presenter.newPhotoArray.count > 0 {
            showErrorOnEmptyGallery(show: false)
            return presenter.newPhotoArray.count
        } else {
            showErrorOnEmptyGallery(show: true)
            return 0
        }
        default:
            if presenter.popularPhotoArray.count > 0 {
                showErrorOnEmptyGallery(show: false)
                return presenter.popularPhotoArray.count
            } else {
                showErrorOnEmptyGallery(show: true)
                return 0
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as? PhotoCell {
            switch newPopularSegCntrl.selectedIndex {
            case 0:
                guard let photo = presenter?.newPhotoArray[indexPath.row].image?.name else {
                    return UICollectionViewCell()
                }
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 10
                cell.setupImage(photo)
                return cell
            case 1:
                guard let photo = presenter?.popularPhotoArray[indexPath.row].image?.name else {
                    return UICollectionViewCell()
                }
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 10
                cell.setupImage(photo)
                return cell
            default:
                return UICollectionViewCell()
            }
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.openDetailedPhoto(photoIndex: indexPath.row, newPopularSegCntrlIndex: newPopularSegCntrl.selectedIndex)
    }

    // TODO: switch case relied on segmented control state
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.presenter!.newPhotoArray.count - 1 {
            self.presenter?.fetchNewPhotosWithPagination(imageName: nil)
        } else if indexPath.row == self.presenter!.popularPhotoArray.count - 1 {
            self.presenter?.fetchPopularPhotosWithPagination(imageName: nil)

        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch newPopularSegCntrl.selectedIndex {
        case 0:
            presenter?.currentStateOfNewCollection = scrollView.contentOffset.y
        case 1:
            presenter?.currentStateOfPopularCollection = scrollView.contentOffset.y
        default:
            break
        }
    }
}
