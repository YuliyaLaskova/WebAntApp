//
//  PhotoCell.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 21.06.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet var myImageView: UIImageView! {
        didSet {
            myImageView.contentMode = .scaleToFill
        }
    }
}

