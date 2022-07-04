//
//  AddDataPresenter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import UIKit

protocol AddDataPresenter {
    func takeImageForPost() -> UIImage
    func postPhoto(_ image: UIImage, _ photo: PhotoEntityForPost)
}
