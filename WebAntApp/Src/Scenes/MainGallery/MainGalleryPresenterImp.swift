//
//  MainGalleryPresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 21.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import RxSwift

class MainGalleryPresenterImp: MainGalleryPresenter {

    var currentStateOfNewCollection: CGFloat = 0
    var currentStateOfPopularCollection: CGFloat = 0

    private weak var view: MainGalleryView?
    private let router: MainGalleryRouter
    private let paginationUseCase: PaginationUseCase
    private let disposeBag = DisposeBag()
    private var requestDisposeBag = DisposeBag()
    private var paginationDisposeBag = DisposeBag()
    var newPhotoArray: [PhotoEntityForGet] = []
    var popularPhotoArray: [PhotoEntityForGet] = []
    var currentCollection: CollectionType

    var isNewsLoadingInProgress: Bool {  return self.paginationUseCase.isLoadingInProcess }

    init(view: MainGalleryView,
         router: MainGalleryRouter,paginationUseCase: PaginationUseCase, collectionType: CollectionType) {
        self.view = view
        self.router = router
        self.paginationUseCase = paginationUseCase
        self.currentCollection = collectionType
    }

    func viewDidLoad() {
        self.subscribeOnNewPhotoUpdates()
        self.subscribeOnPopularPhotoUpdates()
        self.fetchNewPhotosWithPagination()
    }

    func subscribeOnNewPhotoUpdates() {
        paginationUseCase.sourceForNewPhotos
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (result: [PhotoEntityForGet]) in
                guard let self = self else {
                    return
                }
                self.newPhotoArray = result
                self.view?.refreshPhotoCollection()
            })
            .disposed(by: self.paginationDisposeBag)
    }

    func subscribeOnPopularPhotoUpdates() {
        paginationUseCase.sourceForPopularPhotos
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (result: [PhotoEntityForGet]) in
                guard let self = self else {
                    return
                }
                self.popularPhotoArray = result
                self.view?.refreshPhotoCollection()
            })
            .disposed(by: self.paginationDisposeBag)
    }

    func fetchNewPhotosWithPagination(imageName: String? = nil) {
        self.requestDisposeBag = DisposeBag()
        guard self.paginationUseCase.hasMoreNewItems(),
              !isNewsLoadingInProgress else {
            return
        }
        self.paginationUseCase.getMoreNewPhotos(imageName: imageName)
            .observe(on: MainScheduler.instance)
            .do(onSubscribe: { [weak view = self.view] in
                view?.actIndicatorStartAnimating()
            },
                onDispose: { [weak view = self.view] in
                view?.actIndicatorStopAnimating()
            })
            .subscribe(onCompleted: { [weak self] in
                self?.view?.refreshPhotoCollection()
            }, onError: { [weak self] error in
                self?.view?.addInfoModuleWithFunc(
                    alertTitle: R.string.scenes.error(),
                    alertMessage: error.localizedDescription,
                    buttonMessage: R.string.scenes.okAction()
                )
            })
            .disposed(by: self.requestDisposeBag)
    }

    func fetchPopularPhotosWithPagination(imageName: String? = nil) {
        self.requestDisposeBag = DisposeBag()
        guard self.paginationUseCase.hasMorePopularItems(),
              !isNewsLoadingInProgress

        else {
            return
        }
        self.paginationUseCase.getMorePopularPhotos(imageName: imageName)
            .observe(on: MainScheduler.instance)
            .do(onSubscribe: { [weak view = self.view] in
                view?.actIndicatorStartAnimating()
            },
                onDispose: { [weak view = self.view] in
                view?.actIndicatorStopAnimating()
            })
                .subscribe(onCompleted: { [weak self]  in
                    self?.view?.refreshPhotoCollection()
                }, onError: { [weak self] error in
                    self?.view?.addInfoModuleWithFunc(
                        alertTitle: R.string.scenes.error(),
                        alertMessage: error.localizedDescription,
                        buttonMessage: R.string.scenes.okAction()
                    )
                })
                .disposed(by: self.requestDisposeBag)
                }

    func openDetailedPhoto(photoIndex: Int, newPopularSegCntrlIndex: CollectionType) {
        switch newPopularSegCntrlIndex {
        case .new: let photo = newPhotoArray[photoIndex]
            router.openDetailedPhotoViewController(imageEntity: photo)
        case .popular: let photo = popularPhotoArray[photoIndex]
            router.openDetailedPhotoViewController(imageEntity: photo)
        }
}

    func refreshPhotos(collectionType: CollectionType, needToLoadPhotos: Bool) {
        paginationUseCase.reset(collectionType: collectionType)
        switch collectionType {
        case .new:
            newPhotoArray.removeAll()
            view?.refreshPhotoCollection()
            if needToLoadPhotos {
                fetchNewPhotosWithPagination(imageName: nil)
            }
            view?.endRefreshing()
        case .popular:
            popularPhotoArray.removeAll()
            view?.refreshPhotoCollection()
            if needToLoadPhotos {
                fetchPopularPhotosWithPagination(imageName: nil)
            }
            view?.endRefreshing()
        }
    }
    deinit {
        self.paginationDisposeBag = DisposeBag()
    }
}
