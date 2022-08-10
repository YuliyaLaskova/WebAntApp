//
//  SettingsRouter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class SettingsRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: SettingsViewController) {
        self.view = view
    }

    func goToWelcomeScene() {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        appDelegate?.openStartScreen(window: appDelegate?.window)
    }
}
