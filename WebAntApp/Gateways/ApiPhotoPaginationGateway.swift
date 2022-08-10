//
//  ApiPhotoPaginationGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 30.06.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol PaginationGateway {
    func getPhotos(_ page: Int, _ limit: Int,_ isNew: Bool, _ name: String?) -> Single<PaginationEntity<PhotoEntityForGet>>
    func getUserPhotos(userId: Int) -> Single<PaginationEntity<PhotoEntityForGet>>
}

class ApiPhotoPaginationGateway: ApiBaseGateway, PaginationGateway {
    func getPhotos(_ page: Int, _ limit: Int, _ isNew: Bool, _ name: String? = nil) -> Single<PaginationEntity<PhotoEntityForGet>> {
        self.apiClient.execute(request: ExtendedApiRequest.getPhotoPaginatedRequest(page, limit, isNew, name))
    }

    func getUserPhotos(userId: Int) -> Single<PaginationEntity<PhotoEntityForGet>>{
        self.apiClient.execute(request: ExtendedApiRequest.getUserPhotosRequest(userId: userId))
    }
}
