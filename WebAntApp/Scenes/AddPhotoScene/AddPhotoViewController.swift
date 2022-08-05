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

    private let imagePicker = UIImagePickerController()

    var array: [UIImage] = [UIImage(named: "Forest")!, UIImage(named: "Field")!, UIImage(named: "Bear")!, UIImage(named: "Flower")!]

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
        //        let nextButton: UIButton = UIButton (type: UIButton.ButtonType.custom)
        //        nextButton.setTitle("Next", for: .normal)
        //        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        //        nextButton.setTitleColor(.systemPink, for: .normal)
        //        nextButton.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        //
        //        nextButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //        let barButton = UIBarButtonItem(customView: nextButton)
        //        navigationItem.rightBarButtonItem = barButton
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
        // передать картинку
        openAddDataViewController()
    }

    @objc func setStandartImage() {
        checkedImage.image = UIImage(named: "photoIcon")
        //        navigationController?.popViewController(animated: true)
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

        //        present(imagePicker, animated: true)
    }
    
}

extension AddPhotoViewController: AddPhotoView {
    func openAddDataViewController() {
        guard let checkedImage = checkedImage.image else { return }
        presenter?.openAddDataViewController(photoForPost: checkedImage)
    }
}

// MARK: Extension CollectionView

extension AddPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource  {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GalleryPhotoCell {
            checkedImage.image = cell.photoView.image
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? GalleryPhotoCell {
            cell.photoView.image = array[indexPath.row]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

// MARK: Extension ImagePickerController

extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            checkedImage.image = image
        }

        dismiss(animated: true)
    }

    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
}