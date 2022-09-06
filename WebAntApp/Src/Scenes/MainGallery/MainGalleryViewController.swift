//
//  MainGalleryViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 21.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//
import Foundation
import UIKit


class MainGalleryViewController: UIViewController {
    
    var presenter: MainGalleryPresenter?
    let refreshControl = UIRefreshControl()
    let searchBar = UISearchBar()

    @IBOutlet var imageCollection: UICollectionView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var errorImage: UIImageView!

    @IBOutlet var newPopularSegmentedControl: CustomSegmentedControl!{
        didSet{
            newPopularSegmentedControl.setButtonTitles(buttonTitles: ["New","Popular"])
            newPopularSegmentedControl.selectorViewColor = .appPink
            newPopularSegmentedControl.selectorTextColor = .black
            newPopularSegmentedControl.backgroundColor = .white
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard self.presenter == nil else { return }
        let currentCollection = self.newPopularSegmentedControl.selectedIndex
        MainGalleryConfigurator.configure(view: self, currentCollection: currentCollection.rawValue)

        presenter?.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupLeftNavigationBarButton(title: "", isBackButtonHidden: true ,selector: nil)
    }

    func setupUI() {
        setupPortraitCollectionOrientation()
        errorImage.isHidden = true

        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = R.string.scenes.searchCase()
        searchBar.searchTextField.addDoneButtonOnKeyboard()

        newPopularSegmentedControl.delegate = self
        imageCollection.delegate = self
        imageCollection.dataSource = self
        imageCollection.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefreshPhotos) , for: .valueChanged)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.orientation.isPortrait {
            setupPortraitCollectionOrientation()
        } else if UIDevice.current.orientation.isLandscape {
            setupLandscapeCollectionOrientation()
        }
    }

    @objc func pullToRefreshPhotos() {
        presenter?.refreshPhotos(collectionType: newPopularSegmentedControl.selectedIndex, needToLoadPhotos: true)
    }

    private func setupPortraitCollectionOrientation() {
        let layout = UICollectionViewFlowLayout()

        let width: CGFloat = ((view.frame.size.width / 2) - 20)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        imageCollection.collectionViewLayout = layout
        view.layoutIfNeeded()
    }

    private func setupLandscapeCollectionOrientation() {
        let layout = UICollectionViewFlowLayout()
        let width: CGFloat = ((view.frame.size.width / 4) - 40)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        imageCollection.collectionViewLayout = layout
        view.layoutIfNeeded()
    }
}
