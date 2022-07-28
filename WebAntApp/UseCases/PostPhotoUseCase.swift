//
//  PostPhotoUseCase.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 24.06.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient


protocol PostPhotoUseCase {

    func postPhoto(_ entity: PhotoEntityForPost) -> Single<PhotoEntityForGet>
    func postMediaObject(_ file: UploadFile) -> Single<MediaObjectEntity>
}

class PostPhotoUseCaseImp: PostPhotoUseCase {

    let postPhotoGateway: PostPhotoGateway

    init(_ gateway: PostPhotoGateway) {
        self.postPhotoGateway = gateway
    }

    func postPhoto(_ entity: PhotoEntityForPost) -> Single<PhotoEntityForGet> {
        postPhotoGateway.postPhoto(entity)
    }

    func postMediaObject(_ file: UploadFile) -> Single<MediaObjectEntity> {
        postPhotoGateway.postMediaObject(file)
    }
}
