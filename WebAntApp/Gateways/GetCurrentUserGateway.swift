//
//  GetCurrentUserGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.07.2022.
//

import Foundation
import RxNetworkApiClient
import RxSwift

protocol GetCurrentUserGateway {
    func getCurrentUser() -> Single<UserEntityForGet>

}

class GetCurrentUserGatewayImp: ApiBaseGateway, GetCurrentUserGateway {
    func getCurrentUser() -> Single<UserEntityForGet> {
        let request: ExtendedApiRequest<UserEntityForGet> = ExtendedApiRequest.getCurrentUser()
        return apiClient.execute(request: request)
    }
}
