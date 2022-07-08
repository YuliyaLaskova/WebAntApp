//
//  UserProfileViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class UserProfileViewController: UIViewController {

    var presenter: UserProfilePresenter?

    @IBOutlet var userPhoto: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userBirthdayLabel: UILabel!
    @IBOutlet var userImageCollection: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()
        userImageCollection.delegate = self
        userImageCollection.dataSource = self
        if presenter == nil {
            UserProfileConfigurator.configure(view: self)
        }
        presenter?.getCurrentUserFromAPI()
    }
}

extension UserProfileViewController: UserProfileView {
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

        guard let presenter = presenter else { return 0}
        return presenter.photoItems.count

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
        print("you tapped item at index \(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.presenter!.photoItems.count - 1 {
            //                self.presenter?.fetchUserPhotos()
        }
    }
}
