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

    private weak var view: MainGalleryView?
    private let router: MainGalleryRouter
//    private let getPhotoUseCase: GetPhotoUseCase
    private let paginationUseCase: PaginationUseCase
    private let disposeBag = DisposeBag()
    private var requestDisposeBag = DisposeBag()
    private var paginationDisposeBag = DisposeBag()

    var isNewsLoadingInProgress: Bool {  return self.paginationUseCase.isLoadingInProcess }
    var photoItems: [PhotoEntityForGet] = []


    init(_ view: MainGalleryView,
         _ router: MainGalleryRouter,_ paginationUseCase: PaginationUseCase) {
        self.view = view
        self.router = router
        self.paginationUseCase = paginationUseCase
    }

    func viewDidLoad() {
        self.subscribeOnPhotoUpdates()
        self.fetchPhotosWithPagination()
    }

    deinit {
        self.paginationDisposeBag = DisposeBag()
    }
//    init(_ view: MainGalleryView,
//         _ router: MainGalleryRouter,_ getPhotoUseCase: GetPhotoUseCase) {
//        self.view = view
//        self.router = router
//        self.getPhotoUseCase = getPhotoUseCase
//    }

    func fetchPhotos() {
//        getPhotoUseCase.getPhoto()
//            .observe(on: MainScheduler.instance)
//            .subscribe { [weak self] photoModel in
//                for item in photoModel.data where item.image != nil {
//                    self?.photoArray.append(item)
//                }
//                self?.view?.refreshPhotoCollection()
//            } onFailure: { error in
//                print(error)
//            } onDisposed: {
//                print("Disposed")
//            }
//            .disposed(by: disposeBag)
    }

    func subscribeOnPhotoUpdates() {
        paginationUseCase.source
            .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] (result: [PhotoEntityForGet]) in
                    guard let self = self else {
                        return
                    }
                    self.photoItems = result

                    self.view?.refreshPhotoCollection(isHidden: true)
            })
            .disposed(by: self.paginationDisposeBag)
    }

    func fetchPhotosWithPagination() {
        self.requestDisposeBag = DisposeBag()
        guard self.paginationUseCase.hasMoreItems(),
              !isNewsLoadingInProgress else { return }
        self.view?.refreshPhotoCollection(isHidden: false)
        self.paginationUseCase.getMorePhotos()
            .observe(on: MainScheduler.instance)
            .do(onSubscribe: { [weak view = self.view] in view?.actIndicatorStartAnimating() },
                onDispose: { [weak view = self.view] in view?.actIndicatorStopAnimating() })
        
//            .do(onDispose: { [weak self] in
//                guard let self = self else { return }
//                self.view?.endRefreshing()
//            })
            .subscribe(onError: { [weak self] error in
                guard let self = self else { return }
                self.view?.refreshPhotoCollection(isHidden: true)
            })
            .disposed(by: self.requestDisposeBag)
    }

    
}
