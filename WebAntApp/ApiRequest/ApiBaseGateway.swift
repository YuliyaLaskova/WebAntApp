//
//  ApiBaseGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 14.06.2022.
//

import Foundation
import RxNetworkApiClient

class ApiBaseGateway {

    let apiClient: ApiClient

    init(_ apiClient: ApiClient) {
        self.apiClient = apiClient
    }
}
