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
            signInUseCase.signIn(username, password)
                    .observe(on: MainScheduler.instance)
                    .do(onSubscribe: { [weak view = self.view] in
                        view?.startActivityIndicator()
                    },
                        onDispose: { [weak view = self.view] in
                        view?.stopActivityIndicator()
                    })
                    .subscribe(onCompleted: { [weak self] in
                        self?.router.openMainGallery()
                    }, onError: { [weak self] error in
                        self?.view?.addInfoModuleWithFunc(
                            alertTitle: R.string.scenes.error(),
                            alertMessage: error.localizedDescription,
                            buttonMessage: R.string.scenes.okAction()
                        )
                    })
                    .disposed(by: disposeBag)
    }
    
    func openSignUpScene() {
        router.openSignUpScene()
    }
}
