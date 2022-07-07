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

    var newPhotoArray: [PhotoEntityForGet] = []
    var popularPhotoArray: [PhotoEntityForGet] = []

    var isNewsLoadingInProgress: Bool {  return self.paginationUseCase.isLoadingInProcess }
    var photoItems: [PhotoEntityForGet] = []


    init(view: MainGalleryView,
         router: MainGalleryRouter,paginationUseCase: PaginationUseCase) {
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
                self.newPhotoArray = result.filter({ photo in
                    photo.new
                })
                self.popularPhotoArray = result.filter({ photo in
                    photo.popular && !photo.new
                })
                //                    self.photoItems = result
                self.view?.refreshPhotoCollection()
            })
            .disposed(by: self.paginationDisposeBag)
    }

    func fetchPhotosWithPagination() {
        self.requestDisposeBag = DisposeBag()
        guard self.paginationUseCase.hasMoreItems(),
              !isNewsLoadingInProgress else { return }
        self.view?.refreshPhotoCollection()
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
                    self.view?.refreshPhotoCollection()
                })
                .disposed(by: self.requestDisposeBag)
                }

    func openDetailedPhoto(photoIndex: Int, newPopularSegCntrlIndex: Int) {

        switch newPopularSegCntrlIndex {
        case 0: let photo = newPhotoArray[photoIndex]
            router.openDetailedPhotoViewController(imageEntity: photo)
        case 1: let photo = popularPhotoArray[photoIndex]
            router.openDetailedPhotoViewController(imageEntity: photo)
        default: break
        }
        //        let photo = photoItems[photoIndex]
        //        router.openDetailedPhotoViewController(imageEntity: photo)
    }

    func refreshPhotos(photoIndex: Int) {
        paginationUseCase.reset()
        switch photoIndex {
        case 0: newPhotoArray.removeAll()
        case 1: popularPhotoArray.removeAll()
        default: break
        }
        view?.refreshPhotoCollection()
        fetchPhotosWithPagination()
        view?.endRefreshing()
    }
}
