//
//  PhotoCell.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 21.06.2022.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {

    @IBOutlet var imageViewInCell: UIImageView! {
        didSet {
            imageViewInCell.contentMode = .scaleToFill
        }
    }

    func setupImage(_ url: String) {
        guard let urlValid = URL(string: "\(Config.apiEndpoint)/media/\(url)") else {
            return
        }
        imageViewInCell.kf.setImage(with: urlValid)
    }
}

