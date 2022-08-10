//
//  GetUserGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 05.07.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol GetUserGateway {
    func getUser(_ iriId: String) -> Single<UserEntityForGet>
}

class GetUserGatewayImp: ApiBaseGateway, GetUserGateway {
    func getUser(_ iriId: String) -> Single<UserEntityForGet> {
        apiClient.execute(request: ExtendedApiRequest.getUserInfoRequest(iriId))
    }

}
