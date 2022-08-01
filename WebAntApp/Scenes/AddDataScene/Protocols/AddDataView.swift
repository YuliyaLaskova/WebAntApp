//
//  AddDataView.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

protocol AddDataView: BaseView {
    func addPressed()
    func actIndicatorStartAnimating() 
    func actIndicatorStopAnimating()
    func showModalView(finished: @escaping () -> Void)
}
