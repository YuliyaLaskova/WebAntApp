//
//  DetailedFhotoVC+Scroll.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 12.08.2022.
//

import Foundation
import UIKit

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

