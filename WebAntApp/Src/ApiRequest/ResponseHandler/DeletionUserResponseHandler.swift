//
//  DeletionUserResponseHandler.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.08.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class DeletionUserResponseHandler: ResponseHandler {
    func handle<T>(
        observer: @escaping SingleObserver<T>,
        request: ApiRequest<T>,
        response: NetworkResponse
    ) -> Bool where T : Decodable, T : Encodable {
        guard let urlResponse = response.urlResponse,
            let nsHttpUrlResponse = urlResponse as? HTTPURLResponse else {
                return false
    }
        switch nsHttpUrlResponse.statusCode {
        case 204:
            observer(.success(EmptyUser() as! T))
            return true
        default:
            break
        }
        return false
    }
}
