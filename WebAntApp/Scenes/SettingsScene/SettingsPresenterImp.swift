//
//  SettingsPresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

class SettingsPresenterImp: SettingsPresenter {
    
    private weak var view: SettingsView?
    private let router: SettingsRouter
    
    init(_ view: SettingsView,
         _ router: SettingsRouter) {
        self.view = view
        self.router = router
    }
    
}
