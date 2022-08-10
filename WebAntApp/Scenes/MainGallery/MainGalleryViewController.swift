//
//  MainGalleryViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 21.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class MainGalleryViewController: UIViewController {
    
    var presenter: MainGalleryPresenter?
    let refreshControl = UIRefreshControl()
    let searchBar = UISearchBar()

    @IBOutlet var imageCollection: UICollectionView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var errorImage: UIImageView!

    @IBOutlet var newPopularSegCntrl: CustomSegmentedControl!{
        didSet{
            newPopularSegCntrl.setButtonTitles(buttonTitles: ["New","Popular"])
            newPopularSegCntrl.selectorViewColor = .systemPink
            newPopularSegCntrl.selectorTextColor = .black
            newPopularSegCntrl.backgroundColor = .white
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if presenter == nil {
            MainGalleryConfigurator.configure(view: self)
        }
        presenter?.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        errorImage.isHidden = true

        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = R.string.scenes.searchCase()

        searchBar.searchTextField.addDoneButtonOnKeyboard()

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .gray

        imageCollection.delegate = self
        imageCollection.dataSource = self
        newPopularSegCntrl.delegate = self

        imageCollection.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefreshPhotos) , for: .valueChanged)

        let layout = UICollectionViewFlowLayout()

        let width: CGFloat = ((view.frame.size.width / 2) - 20)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        imageCollection.collectionViewLayout = layout
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.orientation.isPortrait {
            let layout = UICollectionViewFlowLayout()
            let width: CGFloat = ((view.frame.size.width / 2) - 20)
            layout.itemSize = CGSize(width: width, height: width)
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
            imageCollection.collectionViewLayout = layout

            view.layoutIfNeeded()
        }

        else if UIDevice.current.orientation.isLandscape {
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

    @objc func pullToRefreshPhotos() {
        presenter?.refreshPhotos(photoIndex: newPopularSegCntrl.selectedIndex, needToLoadPhotos: true)
    }

}
