//
//  SignUpPresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

class SignUpPresenterImp: SignUpPresenter {

    private weak var view: SignUpView?
    private let router: SignUpRouter
    private let signUpUseCase: SignInUseCase
    
    init(_ view: SignUpView,
         _ router: SignUpRouter, _ signUpUseCase: SignInUseCase) {
        self.view = view
        self.router = router
        self.signUpUseCase = signUpUseCase
    }


    func signInBtnPressed() {
        router.openSignInScene()
    }
    func signUpBtnPressed(user: UserEntity) {
        signUpUseCase.signIn("", "")
            .subscribe()
    }
}
