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

    func takeImageForPost() -> UIImage {
        return self.photoForPost
    }

    func postPhoto(_ image: UIImage, _ photo: PhotoEntityForPost) {
        guard let data = image.jpegData(compressionQuality: 0.5) else {return}

        let file = UploadFile("file", data, "image")
        print(file)
        postPhotoUseCase.postMediaObject(file)
            .subscribe(onSuccess: { file in
                let newPhoto = PhotoEntityForPost(name: photo.name, description: photo.description, new: true, popular: true, image: file.id)
                self.postPhotoUseCase.postPhoto(newPhoto)
                    .observe(on: MainScheduler.instance)
                    .subscribe { photo in
                        print("##SucceSS\(photo)")
                    } onFailure: { _ in
                        print("error")
                    } onDisposed: {
                        print("Disposed")
                    }
                    .disposed(by: self.disposeBag)
        })
            .disposed(by: self.disposeBag)
}
            }

