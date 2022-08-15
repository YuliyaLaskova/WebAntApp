//
//  DetailedPhotoExtentions.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 09.08.2022.
//

import Foundation
import UIKit


extension DetailedPhotoViewController: DetailedPhotoView {
    func startActivityIndicator() {
        setupActivityIndicator()
    }

    func stopActivityIndicator() {
        removeActivityIndicator()
    }
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
