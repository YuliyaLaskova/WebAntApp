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
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupStrings() {
        // Setup localizable strings
    }
}

extension DetailedPhotoViewController: DetailedPhotoView {
    
}
