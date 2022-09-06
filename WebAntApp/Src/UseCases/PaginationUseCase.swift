//
//  PaginationUseCase.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 30.06.2022.
//

import Foundation
import RxSwift
import SwiftUI

protocol PaginationUseCase {
    var sourceForNewPhotos: PublishSubject<[PhotoEntityForGet]> { get }
    var sourceForPopularPhotos: PublishSubject<[PhotoEntityForGet]> { get }
    var isLoadingInProcess: Bool { get }
    var newCurrentPage: Int { get }
    var newTotalItemsCount: Int? { get }
    var popularTotalItemsCount: Int? { get }

    func hasMoreNewItems() -> Bool
    func hasMorePopularItems() -> Bool
    func getMoreNewPhotos(imageName: String?) -> Completable
    func getMorePopularPhotos(imageName: String?) -> Completable
    func getMoreUserPhotos(userId: Int) -> Completable
    func reset(collectionType: CollectionType)
    func resetUserPhoto(photoIndex: Int)
}

class PaginationUseCaseImp: PaginationUseCase {
    public var sourceForNewPhotos = PublishSubject<[PhotoEntityForGet]>()
    public var sourceForPopularPhotos = PublishSubject<[PhotoEntityForGet]>()
    public var isLoadingInProcess = false
    public var newCurrentPage = 1
    public var popularCurrentPage = 1

    public var limit = 11
    public var newTotalItemsCount: Int?
    public var popularTotalItemsCount: Int?
    public var notNewPhotoTypeItem = 0
    public var notPopularPhotoTypeItem = 0


    private let gateway: PaginationGateway
    private var newItems = [PhotoEntityForGet]()
    private var popularItems = [PhotoEntityForGet]()
    private var requestsBag = DisposeBag()

    init(gateway: PaginationGateway) {
        self.gateway = gateway
    }

    public func hasMoreNewItems() -> Bool {
        guard let totalItemsCount = self.newTotalItemsCount else {
            return true
        }
        return self.newItems.count < totalItemsCount - notNewPhotoTypeItem
    }

    public func hasMorePopularItems() -> Bool {
        guard let totalItemsCount = self.popularTotalItemsCount else {
            return true
        }
        return self.popularItems.count < totalItemsCount - notPopularPhotoTypeItem
    }

    public func getMoreNewPhotos(imageName: String? = nil) -> Completable {
        .deferred {
            self.cancelLoading()
            self.isLoadingInProcess = true

            return self.gateway.getPhotos(self.newCurrentPage, self.limit, true, imageName)
                    .do(onSuccess: { [weak self] (result: PaginationEntity<PhotoEntityForGet>) in
                        guard let self = self else {
                            return
                        }
                        for item in result.data {
                            if item.image?.name != nil {
                                self.newItems.append(item)
                            } else {
                                self.notNewPhotoTypeItem += 1
                            }
                        }
                        self.newCurrentPage += 1
                        self.newTotalItemsCount = result.totalItems
                        self.isLoadingInProcess = false
                        self.sourceForNewPhotos.onNext(self.newItems)
                    }, onError: { error in
                        self.isLoadingInProcess = false
                        print("PaginationSourceUseCase: catch error =", error.localizedDescription)
                    })
                    .asCompletable()
        }
    }

    public func getMorePopularPhotos(imageName: String? = nil) -> Completable {
        .deferred {
            self.cancelLoading()
            self.isLoadingInProcess = true

            return self.gateway.getPhotos(self.popularCurrentPage, self.limit, false, imageName)
                    .do(onSuccess: { [weak self] (result: PaginationEntity<PhotoEntityForGet>) in
                        guard let self = self else {
                            return
                        }
                        for item in result.data {
                            if item.image?.name != nil {
                                self.popularItems.append(item)
                            } else {
                                self.notPopularPhotoTypeItem += 1
                            }
                        }
                        self.popularCurrentPage += 1
                        self.popularTotalItemsCount = result.totalItems
                        self.isLoadingInProcess = false
                        self.sourceForPopularPhotos.onNext(self.popularItems)
                    }, onError: { error in
                        self.isLoadingInProcess = false
                        print("PaginationSourceUseCase: catch error =", error.localizedDescription)
                    })
                    .asCompletable()
        }
    }

    func getMoreUserPhotos(userId: Int) -> Completable {
        .deferred {
            self.cancelLoading()
            self.isLoadingInProcess = true
            return self.gateway.getUserPhotos(userId: userId)
                .observe(on: MainScheduler.instance)
                .do(onSuccess: { [weak self] (result: PaginationEntity<PhotoEntityForGet>) in
                    guard let self = self else {
                        return
                    }
                    for item in result.data {
                        if item.image?.name != nil {
                            self.newItems.append(item)
                        } else {
                            self.notNewPhotoTypeItem += 1
                        }
                    }
                    self.newCurrentPage += 1
                    self.newTotalItemsCount = result.totalItems
                    self.isLoadingInProcess = false
                    self.sourceForNewPhotos.onNext(self.newItems)
                }, onError: { error in
                    self.isLoadingInProcess = false
                    print("PaginationSourceUseCase: catch error =", error.localizedDescription)
                })
                    .asCompletable()

        }
    }

    public func resetUserPhoto(photoIndex: Int) {
        switch photoIndex {
        case 0:
            self.newItems.removeAll()
            self.newTotalItemsCount = nil
            self.newCurrentPage = 1
            self.notNewPhotoTypeItem = 0
        default: break
        }
    }

    public func reset(collectionType: CollectionType) {
        switch collectionType {
        case .new:
            self.newItems.removeAll()
            self.newTotalItemsCount = nil
            self.newCurrentPage = 1
            self.notNewPhotoTypeItem = 0
        case .popular:
            self.popularItems.removeAll()
            self.popularTotalItemsCount = nil
            self.popularCurrentPage = 1
            self.notPopularPhotoTypeItem = 0
        }
    }

    private func cancelLoading() {
        requestsBag = DisposeBag()
    }
}
