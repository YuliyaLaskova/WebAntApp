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
import Accelerate
import RxSwift

class SignUpPresenterImp: SignUpPresenter {
    private weak var view: SignUpView?
    private let router: SignUpRouter
    private let signUpUseCase: SignUpUseCase
    private let signInUseCase: SignInUseCase
    private let disposeBag = DisposeBag()
    
    init(view: SignUpView,
         router: SignUpRouter,
         signUpUseCase: SignUpUseCase,
         signInUseCase: SignInUseCase) {
        self.view = view
        self.router = router
        self.signUpUseCase = signUpUseCase
        self.signInUseCase = signInUseCase
    }


    func openSignInScene() {
        router.openSignInScene()
    }
    
    func registrateAndOpenMainGalleryScene(user: UserEntity) {
        signUpUseCase.signUp(user)
            .do(onSubscribe: {  [weak self] in
                self?.view?.startActivityIndicator()
            })
            .observe(on: MainScheduler.instance)
                .subscribe { [weak self] _ in
                    guard let strongSelf = self else {
                        return
                    }
                    self?.signInUseCase.signIn(user.email, user.password)
                        .observe(on: MainScheduler.instance)
                        .subscribe(onCompleted: {
                            self?.router.openMainGalleryScene()
                        }, onError: { [weak self] error in
                            self?.view?.stopActivityIndicator()
                            self?.view?.addInfoModuleWithFunc(
                                alertTitle: R.string.scenes.error(),
                                alertMessage: error.localizedDescription,
                                buttonMessage: R.string.scenes.okAction()
                            )
                        })
                        .disposed(by: strongSelf.disposeBag)
                }
                .disposed(by: self.disposeBag)
    }
}
