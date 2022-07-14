//
//  DetailedPhotoViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 01.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class DetailedPhotoViewController: UIViewController {
    
    internal var presenter: DetailedPhotoPresenter?
        
    @IBOutlet var detailedPhoto: UIImageView!
    @IBOutlet var photoNameTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var dateTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let photo = presenter?.getPhotoModel() else {
            return
        }
        presenter?.getUserInfo(photo.user ?? "")

        presenter?.setImage()


//        setupNavigationBarItem()
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
        photoNameTextField.text = name ?? ""
        descriptionTextView.text = desription ?? ""
        dateTextField.text = dateCreation?.convertDateFormatFromISO8601() ?? ""
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
        userNameTextField.text = username

    }
}
