//
//  ApiPhotoPaginationGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 30.06.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class ApiPhotoPaginationGateway: ApiBaseGateway, PaginationGateway {
    func getPhotos(_ page: Int, _ limit: Int) -> Single<PaginationEntity<PhotoEntityForGet>> {
        self.apiClient.execute(request: ExtendedApiRequest.getPhotoPaginated(page, limit))
    }
}
