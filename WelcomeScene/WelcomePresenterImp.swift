//
//  WelcomePresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

class WelcomePresenterImp: WelcomePresenter {

    func signInBtnPressed() {
        router.openSignInScene()
        print("presenter")
    }

    func signUpBtnPressed() {
        router.openSignUpScene()
    }

    
    private var view: WelcomeView?
    private let router: WelcomeRouter
    
    init(_ view: WelcomeView,
         _ router: WelcomeRouter) {
        self.view = view
        self.router = router
    }
    
}
