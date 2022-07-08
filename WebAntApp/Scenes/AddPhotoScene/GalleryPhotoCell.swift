//
//  GalleryPhotoCell.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 23.06.2022.
//

import UIKit

class GalleryPhotoCell: UICollectionViewCell {

    @IBOutlet var photoView: UIImageView! {
        didSet {
            photoView.contentMode = .scaleToFill
        }
    }
}
