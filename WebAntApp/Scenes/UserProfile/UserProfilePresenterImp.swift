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
    private var getCurrentUserUseCase: GetCurrentUserUseCase
    private let paginationUseCase: PaginationUseCase
    private var currentUser: UserEntityForGet?
    var photoItems: [PhotoEntityForGet] = []
    private var requestDisposeBag = DisposeBag()
    private var paginationDisposeBag = DisposeBag()
    private var disposeBag = DisposeBag()
    var isPhotoLoadingInProgress: Bool {  return self.paginationUseCase.isLoadingInProcess }
    
    init(
        view: UserProfileView,
        router: UserProfileRouter,
        getCurrentUserUseCase: GetCurrentUserUseCase,
        paginationUseCase: PaginationUseCase
    ) {
        self.view = view
        self.router = router
        self.getCurrentUserUseCase = getCurrentUserUseCase
        self.paginationUseCase = paginationUseCase
    }

    func viewDidLoad() {
        subscribeOnPhotoUpdates()
        getCurrentUserFromAPI()
    }
    deinit {
        self.paginationDisposeBag = DisposeBag()
    }

    func getCurrentUserFromAPI() {
        getCurrentUserUseCase.getCurrentUser()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] returningUser in
                self?.currentUser = returningUser
                self?.view?.setupUser(user: returningUser)
                self?.fetchUserPhotos()
            }, onFailure: { [weak self] error in
                self?.view?.addInfoModuleWithFunc(
                    alertTitle: R.string.scenes.error(),
                    alertMessage: error.localizedDescription,
                    buttonMessage:  R.string.scenes.okAction()
                )
            })
            .disposed(by: disposeBag)
    }

    func getCurrentUser() -> UserEntityForGet? {
        currentUser
    }

    func fetchUserPhotos() {
        guard self.paginationUseCase.hasMoreNewItems(),
              !isPhotoLoadingInProgress else { return }
        self.view?.refreshPhotoCollection()
        guard let userId = currentUser?.id else { return }
        self.paginationUseCase.getMoreUserPhotos(userId: userId)
            .observe(on: MainScheduler.instance)
            .do(onSubscribe: { [weak view = self.view] in
                view?.startActivityIndicator()
                view?.refreshPhotoCollection()
            },
                onDispose: { [weak view = self.view] in
                view?.stopActivityIndicator()
            })
                .subscribe(onError: { [weak self] error in
                    guard let self = self else { return }
                    self.view?.addInfoModuleWithFunc(alertTitle: R.string.scenes.error(),
                                            alertMessage: error.localizedDescription,
                                            buttonMessage: R.string.scenes.okAction())
                })
                .disposed(by: self.requestDisposeBag)
                }

    func subscribeOnPhotoUpdates() {
        paginationUseCase.sourceForNewPhotos
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (result: [PhotoEntityForGet]) in
                guard let self = self else {
                    return
                }
                self.photoItems = result
                self.view?.refreshPhotoCollection()
            })
            .disposed(by: self.paginationDisposeBag)
    }

    func refreshPhotos(photoIndex: Int) {
        paginationUseCase.reset(photoIndex: photoIndex)
        view?.refreshPhotoCollection()
        fetchUserPhotos()
        view?.endRefreshing()
    }

    func openDetailedPhoto(photoIndex: Int) {
        let photo = photoItems[photoIndex]
        router.openDetailedPhotoViewController(imageEntity: photo)
    }

    func goToSettingScene() {
        router.openSettingsViewController()
    }
}
