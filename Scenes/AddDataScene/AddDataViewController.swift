//
//  AddDataViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class AddDataViewController: UIViewController {
    
    internal var presenter: AddDataPresenter?
        
    @IBOutlet var photoToPost: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBarButtonItems()
    }
    
    private func setupBarButtonItems() {

        let addRightBarButtonItem = UIBarButtonItem()
        addRightBarButtonItem.title = "Add"
        addRightBarButtonItem.tintColor = .systemPink
        addRightBarButtonItem.target = self
//        nextRightBarButtonItem.action = #selector(addBtnPressed)

        navigationItem.rightBarButtonItem = addRightBarButtonItem
        let cancelLeftBarButtonItem = UIBarButtonItem()

//        navigationItem.backBarButtonItem = cancelLeftBarButtonItem
//        cancelLeftBarButtonItem.style = .done
//        cancelLeftBarButtonItem.title = "Cancel"
//        cancelLeftBarButtonItem.tintColor = .gray
//        cancelLeftBarButtonItem.target = self

        navigationItem.leftBarButtonItem = cancelLeftBarButtonItem
        cancelLeftBarButtonItem.title = "Cancel"
        cancelLeftBarButtonItem.tintColor = .gray
        cancelLeftBarButtonItem.target = self
        cancelLeftBarButtonItem.action = #selector(goBack)

    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension AddDataViewController: AddDataView {
    
}
