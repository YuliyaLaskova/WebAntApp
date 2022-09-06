//
//  SignInGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 15.06.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol SignInGateway {
    func authorize(login: String, password: String) -> Single<Token>
    func refreshToken(refreshToken: String) -> Single<Token>
}

class SignInGatewayImp: ApiBaseGateway, SignInGateway {
    func refreshToken(refreshToken: String) -> Single<Token> {
        apiClient.execute(request: ExtendedApiRequest.tokenRefreshRequest(refreshToken))
    }

    func authorize(login: String, password: String) -> Single<Token> {
       return apiClient.execute(request: ExtendedApiRequest.signInRequest(login: login, password: password))

    }
}
