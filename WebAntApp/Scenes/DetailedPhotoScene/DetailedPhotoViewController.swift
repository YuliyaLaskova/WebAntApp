//
//  DetailedPhotoViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 01.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//
import Foundation
import UIKit

class DetailedPhotoViewController: UIViewController {
    
    internal var presenter: DetailedPhotoPresenter?
    @IBOutlet var viewsTextField: DesignableUITextField!
    @IBOutlet var detailedPhoto: UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var photoNameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var stackView: UIStackView!



    override func viewDidLoad() {
        super.viewDidLoad()
        guard let photo = presenter?.getPhotoModel() else {
            return
        }

        scrollView.delegate = self

        detailedPhoto.isUserInteractionEnabled = true
        descriptionTextView.isEditable = false
        viewsTextField.isUserInteractionEnabled = false
    
        presenter?.getUserInfo(photo.user ?? "")

        presenter?.setImage()
        setupZooming()
//        setupNavigationBarItem()
    }

    func setupZooming() {
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 10
        photoNameLabel.isHidden = false
        descriptionTextView.isHidden = false
        self.reloadInputViews()
        scrollView.layoutSubviews()
        scrollView.setNeedsDisplay()
        stackView.layoutSubviews()
        stackView.updateConstraints()
    }

    func setupNavigationBarItem() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem.init(
//              title: "Cancel",
//              style: .done,
//              target: self,
//            action: #selector(goBack)
//        )
//        self.navigationItem.leftBarButtonItem = cancelButton
//        cancelButton.tintColor = .gray
    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }

}

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
