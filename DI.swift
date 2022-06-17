//
//  DI.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 16.06.2022.
//

import Foundation

import DITranquillity
import RxNetworkApiClient

class DI {

    static var container = DIContainer()

    static func initDependencies(appDelegate: AppDelegate) {

        self.container.register { () -> ApiClientImp in
//            let config = URLSessionConfiguration.default
//            config.timeoutIntervalForRequest = 60 * 20
//            config.timeoutIntervalForResource = 60 * 20
//            config.waitsForConnectivity = true
//            config.shouldUseExtendedBackgroundIdleMode = true
//            config.urlCache?.removeAllCachedResponses()



            let client = ApiClientImp.defaultInstance(host: Config.apiEndpoint)
//            (urlSessionConfiguration: config, completionHandlerQueue: .main)
//            client.responseHandlersQueue.append(ErrorResponseHandler())
//            client.responseHandlersQueue.append(JsonResponseHandler())
//            client.responseHandlersQueue.append(NSErrorResponseHandler())

            return client
        }
        .as(ApiClient.self)
        .lifetime(.single)


        self.container.register(SignInGatewayImp.init)
                    .as(SignInGateway.self)
                    .lifetime(.single)

        self.container.register(SignUpGatewayImp.init)
                    .as(SignUpGateway.self)
                    .lifetime(.single)

        self.container.register(SignUpUseCaseImp.init)
                   .as(RegistrationUseCase.self)

        self.container.register(SignInUseCaseImp.init)
                   .as(SignInUseCase.self)


    }

    static func resolve<T>() -> T {
        return self.container.resolve()
    }
}
