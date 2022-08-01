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
import RxSwift

class SettingsPresenterImp: SettingsPresenter {
    
    private weak var view: SettingsView?
    private let router: SettingsRouter
    private var currentUser: UserEntityForGet?
    private var getCurrentUserUseCase: GetCurrentUserUseCase
    var disposeBag = DisposeBag()

    
    init(_ view: SettingsView,
         _ router: SettingsRouter, _ getCurrentUserUseCase: GetCurrentUserUseCase) {
        self.view = view
        self.router = router
        self.getCurrentUserUseCase = getCurrentUserUseCase
    }

    func viewDidLoad() {
        getCurrentUserFromAPI()
    }

    func getCurrentUserFromAPI() {
        getCurrentUserUseCase.getCurrentUser()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] returningUser in
                self?.currentUser = returningUser
                self?.view?.setupUser(user: returningUser)
            }, onFailure: { error in
                print("@@@ error\(error)")
            })
            .disposed(by: disposeBag)
    }
    func getCurrentUser() -> UserEntityForGet? {
        currentUser
    }
}
