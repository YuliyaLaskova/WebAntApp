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
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let settingsBarButtonItem = UIBarButtonItem()
        settingsBarButtonItem.image = UIImage(named: "gear")
        settingsBarButtonItem.tintColor = .black
        settingsBarButtonItem.target = self
        settingsBarButtonItem.action = #selector(settingsBtnPressed)

        navigationItem.rightBarButtonItem = settingsBarButtonItem

        profilePhotoView.layer.borderWidth = 1
        profilePhotoView.layer.borderColor = UIColor.systemGray5.cgColor
        profileBackgroundView.layer.borderWidth = 1
        profileBackgroundView.layer.borderColor = UIColor.systemGray5.cgColor
        errorImage.isHidden = true

        if presenter == nil {
            UserProfileConfigurator.configure(view: self)
        }
        presenter?.viewDidLoad()

        setupCollection()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupLeftNavigationBarButton(title: "Table", isBackButtonHidden: true, selector:#selector(openTableScreen))

    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.orientation.isPortrait {
            setupPortraitCollectionOrientation()
        } else if UIDevice.current.orientation.isLandscape {
            setupLandscapeCollectionOrientation()
        }
    }

    @objc func openTableScreen() {
        presenter?.goToTableScene()
    }

    @objc func pullToRefreshPhotos() {
        presenter?.refreshUserPhotos(photoIndex: 0)
    }

    @objc func settingsBtnPressed() {
        openSettingsScene()
    }

    private func setupCollection() {
        userImageCollection.delegate = self
        userImageCollection.dataSource = self
        setupPortraitCollectionOrientation()
        userImageCollection.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefreshPhotos) , for: .valueChanged)

    }

    private func setupPortraitCollectionOrientation() {
        // левый спейсинг + правый спейсинг + отступ между 3 элементами(тк мы хотим 4 элемента)
        let layout = UICollectionViewFlowLayout()
        let width: CGFloat = ((view.frame.size.width - 47) / 4)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        userImageCollection.collectionViewLayout = layout
        layout.invalidateLayout()
    }

    private func setupLandscapeCollectionOrientation() {
        let layout = UICollectionViewFlowLayout()
        let width: CGFloat = ((view.frame.size.width - 125) / 6)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 50, bottom: 10, right: 50)
        userImageCollection.collectionViewLayout = layout
        layout.invalidateLayout()
    }
}
