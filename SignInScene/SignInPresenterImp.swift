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
         router: SignInRouter, signInUseCase: SignInUseCase) {
        self.view = view
        self.router = router
        self.signInUseCase = signInUseCase
    }

    func signInBtnPressed(username: String, password: String) {
        signInUseCase.signIn(username, password)
            .subscribe {
                print("Router")
                // router
            } onDisposed: {
                print("Disposed")
            }
            .disposed(by: disposeBag)

    }

    func signUpBtnPressed() {
        router.openSignUpScene()
    }

}
