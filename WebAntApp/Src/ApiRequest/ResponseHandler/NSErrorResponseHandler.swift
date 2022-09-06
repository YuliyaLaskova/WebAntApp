//
//  NSErrorResponseHandler.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.08.2022.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class NSErrorResponseHandler: ResponseHandler {

    public init() {
    }

    public func handle<T: Codable>(observer: @escaping SingleObserver<T>,
                                   request: ApiRequest<T>,
                                   response: NetworkResponse) -> Bool {
        if let error = (response.error as NSError?) {
            let errorResponseEntity = ResponseErrorEntity(response.urlResponse)
            let errorDesc = error.code == -1001 ? error.localizedDescription + "\n" /*+ R.string.localizable.tryAgain() LOCALIZABLE */ : error.localizedDescription
            errorResponseEntity.errors.append(errorDesc)
            observer(.failure(errorResponseEntity))
            return true
        }

        if let nextError = (response.error as NSError?) {
            let errorResponseEntity = ResponseErrorEntity(response.urlResponse)
            let errorDesc = nextError.code == -400 ? nextError.localizedDescription + "\n" /*+ R.string.localizable.tryAgain() LOCALIZABLE */ : nextError.localizedDescription
            errorResponseEntity.errors.append(errorDesc)
            observer(.failure(errorResponseEntity))
            return true
        }

        if let nextNextError = (response.error as NSError?) {
            let errorResponseEntity = ResponseErrorEntity(response.urlResponse)
            let errorDesc = nextNextError.code == 400 ? nextNextError.localizedDescription + "\n" /*+ R.string.localizable.tryAgain() LOCALIZABLE */ : nextNextError.localizedDescription
            errorResponseEntity.errors.append(errorDesc)
            observer(.failure(errorResponseEntity))
            return true
        }
        return false
    }
}
