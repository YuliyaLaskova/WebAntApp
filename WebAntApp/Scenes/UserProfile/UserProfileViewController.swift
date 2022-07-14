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

    @IBOutlet var errorImage: UIImageView!
    @IBOutlet var profileBackgroundView: UIView!
    @IBOutlet var profilePhotoView: UIView!
    @IBOutlet var userPhoto: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userBirthdayLabel: UILabel!
    @IBOutlet var userImageCollection: UICollectionView!
    private let refreshControl = UIRefreshControl()


    override func viewDidLoad() {
        super.viewDidLoad()
        userImageCollection.delegate = self
        userImageCollection.dataSource = self

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .gray

        let layout = UICollectionViewFlowLayout()
        userImageCollection.collectionViewLayout = layout

        let width: CGFloat = ((view.frame.size.width - 47) / 4)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)

        profilePhotoView.layer.borderWidth = 1
        profilePhotoView.layer.borderColor = UIColor.systemGray5.cgColor
        profileBackgroundView.layer.borderWidth = 1
        profileBackgroundView.layer.borderColor = UIColor.systemGray5.cgColor
        errorImage.isHidden = true

        userImageCollection.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefreshPhotos) , for: .valueChanged)

        if presenter == nil {
            UserProfileConfigurator.configure(view: self)
        }
        presenter?.viewDidLoad()
    }
    

    @objc func pullToRefreshPhotos() {
        presenter?.refreshPhotos(photoIndex: 0)
    }
}

extension UserProfileViewController: UserProfileView {
    func refreshPhotoCollection() {
        userImageCollection.reloadData()
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
    }

    func actIndicatorStartAnimating() {
    }

    func actIndicatorStopAnimating() {

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
