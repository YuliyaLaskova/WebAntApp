//
//  AddPhotoVCExtentions.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.08.2022.
//

import Foundation
import UIKit

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
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? GalleryPhotoCell {
            cell.photoView.image = imageArray[indexPath.row]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
