//
//  PostPhotoGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 24.06.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol PostPhotoGateway {
    func postMediaObject(_ file: UploadFile) -> Single<MediaObjectEntity>
    func postPhoto(_ photo: PhotoEntityForPost) -> Single<PhotoEntityForPost>
}


class PostPhotoGatewayImp: ApiBaseGateway, PostPhotoGateway {

    func postMediaObject(_ file: UploadFile) -> Single<MediaObjectEntity> {
        apiClient.execute(request: ExtendedApiRequest.postMediaObject(file: file))
    }

    func postPhoto(_ photo: PhotoEntityForPost) -> Single<PhotoEntityForPost> {
        apiClient.execute(request: ExtendedApiRequest.postPhoto(photo: photo))
    }
}