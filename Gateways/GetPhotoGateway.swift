//
//  GetPhotoGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 23.06.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol GetPhotoGateway {

    func getPhoto() -> Single<PhotoModel>
}

class GetPhotoGatewayImp: ApiBaseGateway, GetPhotoGateway {

    func getPhoto() -> Single<PhotoModel> {
        apiClient.execute(request: ExtendedApiRequest.getPhoto())
    }
}
