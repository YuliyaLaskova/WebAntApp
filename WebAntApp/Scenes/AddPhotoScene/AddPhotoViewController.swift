//
//  AddPhotoViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 23.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class AddPhotoViewController: UIViewController {
    var presenter: AddPhotoPresenter?
    let imagePicker = UIImagePickerController()
//    var array: [UIImage] = [UIImage(named: "Forest")!, UIImage(named: "Field")!, UIImage(named: "Bear")!, UIImage(named: "Flower")!]
    var imageArray: [UIImage] = []

    @IBOutlet var photoCollection: UICollectionView!
    @IBOutlet var checkedImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        if presenter == nil {
            AddPhotoConfigurator.configure(view: self)
        }
    }

    func setupUI() {
        photoCollection.delegate = self
        photoCollection.dataSource = self

        setupBarButtonItems()

        let layout = UICollectionViewFlowLayout()
        photoCollection.collectionViewLayout = layout

        let width: CGFloat = ((view.frame.size.width - 47) / 4)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)

        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        checkedImage.isUserInteractionEnabled = true
        tapObserver()
    }

    private func setupBarButtonItems() {
        let nextRightBarButtonItem = UIBarButtonItem()
        nextRightBarButtonItem.title = "Next"
        nextRightBarButtonItem.tintColor = .systemPink
        nextRightBarButtonItem.target = self
        nextRightBarButtonItem.action = #selector(nextBtnPressed)

        navigationItem.rightBarButtonItem = nextRightBarButtonItem

        let cancelLeftBarButtonItem = UIBarButtonItem()
        cancelLeftBarButtonItem.title = "Cancel"
        cancelLeftBarButtonItem.tintColor = .gray
        cancelLeftBarButtonItem.target = self
        cancelLeftBarButtonItem.action = #selector(setStandartImage)

        navigationItem.leftBarButtonItem = cancelLeftBarButtonItem
    }

    @objc func nextBtnPressed() {
        openAddDataViewController()
    }

    @objc func setStandartImage() {
        checkedImage.image = nil
    }

    private func tapObserver() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapImage)
        )
        checkedImage.addGestureRecognizer(tapGesture)
    }

    @objc func didTapImage() {
        let alert = UIAlertController(title: "Choose the source", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
