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

    var isNewsLoadingInProgress: Bool {  return self.paginationUseCase.isLoadingInProcess }

    init(view: MainGalleryView,
         router: MainGalleryRouter,paginationUseCase: PaginationUseCase) {
        self.view = view
        self.router = router
        self.paginationUseCase = paginationUseCase
    }

    func viewDidLoad() {
        self.subscribeOnNewPhotoUpdates()
        self.subscribeOnPopularPhotoUpdates()
        self.fetchNewPhotosWithPagination()
    }
    deinit {
        self.paginationDisposeBag = DisposeBag()
    }


    func subscribeOnNewPhotoUpdates() {
        paginationUseCase.sourceForNewPhotos
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (result: [PhotoEntityForGet]) in
                guard let self = self else {
                    return
                }
                self.newPhotoArray = result
//                    .filter({ photo in
//                    photo.new ?? true
//                })
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
                guard let self = self else { return }
                self.view?.refreshPhotoCollection()
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: self.requestDisposeBag)
                }

    func fetchPopularPhotosWithPagination(imageName: String? = nil) {
        self.requestDisposeBag = DisposeBag()
        guard self.paginationUseCase.hasMorePopularItems(),
              !isNewsLoadingInProgress else { return }
//        self.view?.refreshPhotoCollection()
        self.paginationUseCase.getMorePopularPhotos(imageName: imageName)
            .observe(on: MainScheduler.instance)
            .do(onSubscribe: { [weak view = self.view] in
                view?.actIndicatorStartAnimating()
            },
                onDispose: { [weak view = self.view] in view?.actIndicatorStopAnimating() })
            .subscribe(onCompleted: { [weak self]  in
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

    func refreshPhotos(photoIndex: Int, needToLoadPhotos: Bool) {
        paginationUseCase.reset(photoIndex: photoIndex)
        switch photoIndex {
        case 0:
            newPhotoArray.removeAll()
            view?.refreshPhotoCollection()
            if needToLoadPhotos {
                fetchNewPhotosWithPagination(imageName: nil)
            }
            view?.endRefreshing()

        case 1: if needToLoadPhotos == true {
            popularPhotoArray.removeAll()
            view?.refreshPhotoCollection()
            if needToLoadPhotos {
                fetchPopularPhotosWithPagination(imageName: nil)
            }
            view?.endRefreshing()
        }
        default: break
        }
    }
}

//    private let getPhotoUseCase: GetPhotoUseCase

//    init(_ view: MainGalleryView,
//         _ router: MainGalleryRouter,_ getPhotoUseCase: GetPhotoUseCase) {
//        self.view = view
//        self.router = router
//        self.getPhotoUseCase = getPhotoUseCase
//    }

//    func fetchPhotos() {
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
//    }

//func subscribeOnPhotoUpdates() {
//    paginationUseCase.source
//        .observe(on: MainScheduler.instance)
//        .subscribe(onNext: { [weak self] (result: [PhotoEntityForGet]) in
//            guard let self = self else {
//                return
//            }
//            self.newPhotoArray = result.filter({ photo in
//                photo.new ?? true
//            })
//            self.popularPhotoArray = result.filter({ photo in
//                (photo.popular ?? true) && !(photo.new ?? true)
//            })
//            //                    self.photoItems = result
//            self.view?.refreshPhotoCollection()
//        })
//        .disposed(by: self.paginationDisposeBag)
//}
