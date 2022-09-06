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
    var presenter: DetailedPhotoPresenter?
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

        self.setupLeftNavigationBarButton(title: "", isBackButtonHidden: true, selector: #selector(goBack))

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
    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
