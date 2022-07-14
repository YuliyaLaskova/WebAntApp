//
//  RegistrationGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 14.06.2022.
//

import Foundation
import RxSwift

struct User: Codable {

}

protocol RegistrationGateway {
    func signIn(login: String, password: String) -> Single<User>
}

class RegistrationGatewayImp: ApiBaseGateway, RegistrationGateway {
    func signIn(login: String, password: String) -> Single<User> {
        let request: ExtendedApiRequest<User> = ExtendedApiRequest.signInRequest(login: login, password: password)
        return apiClient.execute(request: request)
    }



}
