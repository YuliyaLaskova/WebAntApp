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

    private lazy var spinner = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    func setupImage(_ url: String) {
        guard let urlValid = URL(string: "\(Config.apiEndpoint)/media/\(url)") else {
            return
        }
        imageViewInCell.kf.setImage(with: urlValid)

    }
}

