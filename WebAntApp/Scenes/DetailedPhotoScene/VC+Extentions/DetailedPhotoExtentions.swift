//
//  DetailedPhotoExtentions.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 09.08.2022.
//

import Foundation
import UIKit

extension DetailedPhotoViewController: DetailedPhotoView {
    func setView(image: String?, name: String?, desription: String?, user: String?, dateCreation: String?) {
        setupImage(image)
        photoNameLabel.text = name ?? ""
        descriptionTextView.text = desription ?? ""
        dateLabel.text = dateCreation?.convertDateFormatFromISO8601() ?? ""
    }

    func setupImage(_ name: String?) {
        guard let name = name else { return }
        guard let urlValid = URL(string: "\(Config.apiEndpoint)/media/\(name)") else {
            return
        }
        detailedPhoto.kf.setImage(with: urlValid)
    }

    func getUsername(username: String?) {
        guard let username = username else {
            return
        }
        userNameLabel.text = username
    }
}

extension DetailedPhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return stackView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        photoNameLabel.isHidden = true
        descriptionTextView.isHidden = true
        dateLabel.isHidden = true
        userNameLabel.isHidden = true
        viewsTextField.isHidden = true
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        photoNameLabel.isHidden = false
        descriptionTextView.isHidden = false
        dateLabel.isHidden = false
        userNameLabel.isHidden = false
        viewsTextField.isHidden = false
    }
}
