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

class MainGalleryViewController: UIViewController{
    
    internal var presenter: MainGalleryPresenter?

    var array: [UIImage] = [UIImage(named: "Fog")!, UIImage(named: "Grass")!]

    @IBOutlet var imageCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    
    func setupUI() {

        imageCollection.delegate = self
        imageCollection.dataSource = self
        let layout = UICollectionViewFlowLayout()
        imageCollection.collectionViewLayout = layout
        view.addSubview(imageCollection)

    }
}

extension MainGalleryViewController: MainGalleryView {
    
}

extension MainGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource  {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as? PhotoCell {
            cell.myImageView.image = array[indexPath.row]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
