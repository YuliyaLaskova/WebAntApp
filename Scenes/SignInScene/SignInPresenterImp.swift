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
import RxSwift

class SignInPresenterImp: SignInPresenter {

    private weak var view: SignInView?
    private let router: SignInRouter
    private let signInUseCase: SignInUseCase
    private let disposeBag = DisposeBag()
    
    init(view: SignInView,
         router: SignInRouter,
         signInUseCase: SignInUseCase) {
        self.view = view
        self.router = router
        self.signInUseCase = signInUseCase
    }

    func signInAndOpenMainGallery(username: String, password: String) {
        //        self.router.openMainGallery()
        if Validator.isStringValid(stringValue: username, validationType: .email) && Validator.isStringValid(stringValue: password, validationType: .password) {
            signInUseCase.signIn(username, password)
                .observe(on: MainScheduler.instance)
                .subscribe {
                    DispatchQueue.main.async {
                        self.router.openMainGallery()
                    }
                } onDisposed: {
                    print("Disposed")
                }
                .disposed(by: disposeBag)
        }
    }
    
    func openSignUpScene() {
        router.openSignUpScene()
    }

}
