//
//  UserProfilePresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import RxSwift

class UserProfilePresenterImp: UserProfilePresenter {

    private weak var view: UserProfileView?
    private let router: UserProfileRouter
    var photoItems: [PhotoEntityForGet] = []
    var getCurrentUserUseCase: GetCurrentUserUseCase
    var currentUser: UserEntityForGet?
    var disposeBag = DisposeBag()
    
    init(_ view: UserProfileView,
         _ router: UserProfileRouter, _ getCurrentUserUseCase: GetCurrentUserUseCase) {
        self.view = view
        self.router = router
        self.getCurrentUserUseCase = getCurrentUserUseCase
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

    func fetchUserPhotos() {
    
    }

    
}
