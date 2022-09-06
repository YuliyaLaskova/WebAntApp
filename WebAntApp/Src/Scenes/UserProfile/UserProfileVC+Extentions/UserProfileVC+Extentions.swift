//
//  UserProfileVC+Extentions.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.08.2022.
//

import Foundation
import UIKit

extension UserProfileViewController: UserProfileView {
    func openSettingsScene() {
        presenter?.goToSettingScene()
    }

    func refreshPhotoCollection() {
        userImageCollection.reloadData()
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
    }

    func startActivityIndicator() {
        setupActivityIndicator()
    }

    func stopActivityIndicator() {
        removeActivityIndicator()
    }

    func showErrorOnEmptyGallery(show: Bool) {
        switch show {
        case true:
            errorImage.isHidden = false
        default:
            errorImage.isHidden = true
        }
    }


    func setupUser(user: UserEntityForGet?) {
        guard let user = presenter?.getCurrentUser() else {
            return
        }
        print("user")
        userNameLabel.text = user.username
        userBirthdayLabel.text = user.birthday?.convertDateFormatFromISO8601()
    }
}

extension UserProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource  {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        if presenter.photoItems.count > 0 {
            showErrorOnEmptyGallery(show: false)
            return presenter.photoItems.count
        } else {
            showErrorOnEmptyGallery(show: true)
            return 0
        }
//        guard let presenter = presenter else { return 0}
//        return presenter.photoItems.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as? PhotoCell {
            guard let photo = presenter?.photoItems[indexPath.row].image?.name else {
                return UICollectionViewCell()
            }
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 10
            cell.setupImage(photo)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.openDetailedPhoto(photoIndex: indexPath.row)
        print("you tapped item at index \(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.presenter!.photoItems.count - 1 {
                            self.presenter?.fetchUserPhotos()
        }
    }
}
