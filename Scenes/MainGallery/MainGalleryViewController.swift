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
    
    internal var presenter: MainGalleryPresenter?

   // var searchBar = UISearchBar()
    var array: [UIImage] = [UIImage(named: "Forest")!, UIImage(named: "Field")!, UIImage(named: "Flower")!, UIImage(named: "Bear")!]

    @IBOutlet var imageCollection: UICollectionView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

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

    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //        imageCollection.frame = view.bounds
    //    }
    
    func setupUI() {

        let searchBar = UISearchBar()
        self.navigationItem.titleView = searchBar

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let backButton = UIBarButtonItem.init(
            title: nil,
            style: .done,
            target: self,
            action: nil
        )
        self.navigationItem.leftBarButtonItem = backButton

        imageCollection.delegate = self
        imageCollection.dataSource = self
        newPopularSegCntrl.delegate = self

        let layout = UICollectionViewFlowLayout()
        imageCollection.collectionViewLayout = layout

        let width: CGFloat = ((view.frame.size.width - 37) / 2)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)

    }

//    func actIndicatorStartAnimating() {
//        activityIndicator.startAnimating()
//    }
}

extension MainGalleryViewController: MainGalleryView {

    func refreshPhotoCollection(isHidden: Bool) {
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


    
}
extension MainGalleryViewController: CustomSegmentedControlDelegate  {
    func change(to index: Int) {
        print("segmentedControl index changed to \(index)")
    }
}

extension MainGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource  {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.photoItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as? PhotoCell {
            guard let photo = presenter?.photoItems[indexPath.row].image?.name else {
                return UICollectionViewCell()
            }
//            if let photo = presenter?.photoItems[indexPath.row].image {
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 10
                cell.setupImage(photo)
                return cell
        }
        else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.presenter!.photoItems.count - 1 {
            self.presenter?.fetchPhotosWithPagination()
        }
    }
}
