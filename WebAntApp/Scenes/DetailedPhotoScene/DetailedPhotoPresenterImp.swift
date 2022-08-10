//
//  DetailedPhotoPresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 01.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import RxSwift

class DetailedPhotoPresenterImp: DetailedPhotoPresenter {
    private weak var view: DetailedPhotoView?
    private let getUserUseCase: GetUserUseCase
    var userName: String?
    var settings: Settings
    let imageModel: PhotoEntityForGet
    private let disposeBag = DisposeBag()
    
    init(view: DetailedPhotoView, imageModel: PhotoEntityForGet, settings: Settings, getUserUseCase: GetUserUseCase) {
        self.view = view
        self.imageModel = imageModel
        self.settings = settings
        self.getUserUseCase = getUserUseCase

    }

    func setImage() {
        view?.setView(image: imageModel.image?.name,
                      name: imageModel.name,
                      desription: imageModel.description,
                      user: imageModel.user,
                      dateCreation: imageModel.dateCreate)
    }

    func getPhotoModel() -> PhotoEntityForGet? {
        return imageModel
    }
    
    func getUserInfo(_ iriId: String) {
        self.getUserUseCase.getUserInfo(iriId)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] user in
                self?.view?.getUsername(username: user.username)
            })
            .disposed(by: self.disposeBag)
    }
}
