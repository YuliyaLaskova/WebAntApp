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
}

extension MainGalleryViewController: MainGalleryView {
    
}

extension MainGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, CustomSegmentedControlDelegate  {
    func change(to index: Int) {
        print("segmentedControl index changed to \(index)")
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as? PhotoCell {
            cell.myImageView.image = array[indexPath.row]
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 10
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
