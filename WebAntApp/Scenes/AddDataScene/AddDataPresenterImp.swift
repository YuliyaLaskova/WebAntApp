//
//  AddDataPresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import UIKit
import RxNetworkApiClient
import RxSwift
import Kingfisher

class AddDataPresenterImp: AddDataPresenter {
    
    private weak var view: AddDataView?
    private let router: AddDataRouter
    let photoForPost: UIImage
    private let postPhotoUseCase: PostPhotoUseCase
    private let disposeBag = DisposeBag()

    init(_ view: AddDataView,
         _ router: AddDataRouter, postPhotoUseCase: PostPhotoUseCase, _ photoForPost: UIImage) {
        self.view = view
        self.router = router
        self.postPhotoUseCase = postPhotoUseCase
        self.photoForPost = photoForPost
    }

    enum RequestError: Error {
        case selfIsNil
    }

    func takeImageForPost() -> UIImage {
        return self.photoForPost
    }

    func postPhoto(_ image: UIImage, _ photo: PhotoEntityForPost) {
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        let file = UploadFile("file", data, "image")
        print(file)
        postPhotoUseCase.postMediaObject(file)
            .do(onSubscribe: { [weak self] in
                self?.view?.startActivityIndicator()
            })
                .flatMap ({ [weak self] file -> Single<PhotoEntityForGet> in
                    guard let strongSelf = self else {
                        return Single.create { observer in
                            observer(.failure(RequestError.selfIsNil))
                            return Disposables.create()
                        }
                    }
                    let newPhoto = PhotoEntityForPost(
                        name: photo.name,
                        description: photo.description,
                        new: true,
                        popular: true,
                        image: file.id
                    )
                    return strongSelf.postPhotoUseCase.postPhoto(newPhoto)

                })
                .observe(on: MainScheduler.instance)
                .subscribe(onSuccess: { [weak self] photo in
                    self?.view?.stopActivityIndicator()
                    self?.view?.showModalView {
                        self?.router.goBackToMainGallery()
                    }
                }, onFailure: { error in
                    self.view?.addInfoModuleWithFunc(
                        alertTitle: R.string.scenes.failInPublicationMessage(),
                        alertMessage: error.localizedDescription,
                        buttonMessage:  R.string.scenes.okAction()
                    )
                })
                .disposed(by: self.disposeBag)
                }

    func backToMainGallery() {
        router.goBackToMainGallery()
    }
}
