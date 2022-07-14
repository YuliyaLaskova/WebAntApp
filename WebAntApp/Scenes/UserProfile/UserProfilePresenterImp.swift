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
    private var getCurrentUserUseCase: GetCurrentUserUseCase
    private var currentUser: UserEntityForGet?

    private let paginationUseCase: PaginationUseCase
     var isNewsLoadingInProgress: Bool {  return self.paginationUseCase.isLoadingInProcess }

    private var requestDisposeBag = DisposeBag()
    private var paginationDisposeBag = DisposeBag()
    var disposeBag = DisposeBag()
    
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
            }, onFailure: { error in
                print("@@@ error\(error)")
            })
            .disposed(by: disposeBag)
    }

    func getCurrentUser() -> UserEntityForGet? {
        currentUser
    }

    func fetchUserPhotos() {
        guard self.paginationUseCase.hasMoreNewItems(),
              !isNewsLoadingInProgress else { return }
        self.view?.refreshPhotoCollection()
        guard let userId = currentUser?.id else { return }
        self.paginationUseCase.getMoreUserPhotos(userId: userId)
            .observe(on: MainScheduler.instance)
            .do(onSubscribe: { [weak view = self.view] in
                view?.actIndicatorStartAnimating()
                view?.refreshPhotoCollection()
            },
                onDispose: { [weak view = self.view] in view?.actIndicatorStopAnimating() })

                .subscribe(onError: { [weak self] error in
                    guard let self = self else { return }
                    self.view?.refreshPhotoCollection()
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
}
