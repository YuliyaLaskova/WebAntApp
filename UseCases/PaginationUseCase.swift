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

    var source: PublishSubject<[PhotoEntityForGet]> { get }
    var isLoadingInProcess: Bool { get }
    var currentPage: Int { get }
    var totalItemsCount: Int? { get }

    func hasMoreItems() -> Bool
    func getMorePhotos() -> Completable
    func reset()
}

class PaginationUseCaseImp: PaginationUseCase {

    public var source = PublishSubject<[PhotoEntityForGet]>()
    public var isLoadingInProcess = false
    public var currentPage = 1
    public var limit = 11
    public var totalItemsCount: Int?
    public var notPhotoTypeItem = 0


    private let gateway: PaginationGateway
    private var items = [PhotoEntityForGet]()
    private var requestsBag = DisposeBag()

    init(gateway: PaginationGateway) {
        self.gateway = gateway
    }

    public func hasMoreItems() -> Bool {

        guard let totalItemsCount = self.totalItemsCount else {
            return true
        }

        return self.items.count < totalItemsCount - notPhotoTypeItem
    }

    public func getMorePhotos() -> Completable {
        .deferred {
            self.cancelLoading()
            self.isLoadingInProcess = true

            return self.gateway.getPhotos(self.currentPage, self.limit)
                    .do(onSuccess: { (result: PaginationEntity<PhotoEntityForGet>) in
                        for item in result.data {
                            if item.image?.name != nil {
                                self.items.append(item)
                                print("item added")
                            } else {
                                self.notPhotoTypeItem += 1
                            }
                        }
                        self.currentPage += 1
                        self.totalItemsCount = result.totalItems
                        self.isLoadingInProcess = false
                        self.source.onNext(self.items)
                    }, onError: { error in
                        self.isLoadingInProcess = false
                        print("PaginationSourceUseCase: catch error =", error.localizedDescription)
                    })
                    .asCompletable()
        }
    }

    public func reset() {
        self.items.removeAll()
        self.totalItemsCount = nil
        self.currentPage = 1
        self.notPhotoTypeItem = 0
    }

    private func cancelLoading() {
        requestsBag = DisposeBag()
    }
}
