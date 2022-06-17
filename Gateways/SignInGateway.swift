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
}

class SignInGatewayImp: ApiBaseGateway, SignInGateway {

    func authorize(login: String, password: String) -> Single<Token> {
       return apiClient.execute(request: ExtendedApiRequest.signIn(login: login, password: password))

    }
}
