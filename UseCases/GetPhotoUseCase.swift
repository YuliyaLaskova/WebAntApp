//
//  PhotoUseCase.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 23.06.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol GetPhotoUseCase {
    func getPhoto(_ photo: PhotoModel) -> Single<PhotoModel>
}

class GetPhotoUseCaseImp: GetPhotoUseCase {

    let getPhotoGateway: GetPhotoGateway

    init(_ gateway: GetPhotoGateway) {
        self.getPhotoGateway = gateway
    }

    func getPhoto(_ photo: PhotoModel) -> Single<PhotoModel> {
        getPhotoGateway.getPhoto(photo)
    }
}

