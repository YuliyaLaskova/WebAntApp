//
//  SignInPresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

class SignInPresenterImp: SignInPresenter {
    
    private weak var view: SignInView?
    private let router: SignInRouter
    
    init(_ view: SignInView,
         _ router: SignInRouter) {
        self.view = view
        self.router = router
    }
    
}
