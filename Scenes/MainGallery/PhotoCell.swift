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

//    private let photoView: UIImageView = {
//        let photoView = UIImageView()
//        photoView.contentMode = .scaleAspectFill
//        photoView.clipsToBounds = true
//        return photoView
//    }()
//
//    func setupCell(withImage:UIImage) {
//        self.photoView.image = withImage
//    }
//
//    override init(frame: CGRect) {
//        super .init(frame: frame)
//        contentView.addSubview(photoView)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("Error")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        photoView.frame = contentView.bounds
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        photoView.image = nil
//    }
//}
