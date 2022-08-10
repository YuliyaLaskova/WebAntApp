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

        self.container.register(AuthInterceptor.init)
            .as(AuthInterceptor.self)
            .lifetime(.single)

        self.container.register {
            AuthResponseHandler(appDelegate, $0, $1, $2)
        }
        .as(AuthResponseHandler.self)
        .lifetime(.single)


        self.container.register { () -> ApiClientImp in
                        let config = URLSessionConfiguration.default
                        config.timeoutIntervalForRequest = 60 * 20
                        config.timeoutIntervalForResource = 60 * 20
                        config.waitsForConnectivity = true
                        config.shouldUseExtendedBackgroundIdleMode = true
                        config.urlCache?.removeAllCachedResponses()

            let client = ApiClientImp.defaultInstance(host: Config.apiEndpoint)
//                        (urlSessionConfiguration: config, completionHandlerQueue: .main)
//                        client.responseHandlersQueue.append(ErrorResponseHandler())
            client.responseHandlersQueue.append(JsonResponseHandler())
//                        client.responseHandlersQueue.append(NSErrorResponseHandler())

            // MARK: add this files
            //            client.interceptors.append(JsonContentInterceptor())
            //            client.interceptors.append(ExtraPathInterceptor())


            return client
        }
        .as(ApiClient.self)
        .injection(cycle: true) {
            $0.responseHandlersQueue.insert($1 as AuthResponseHandler, at: 0)
        }
        .injection(cycle: true) {
            $0.interceptors.insert($1 as AuthInterceptor, at: 0)
        }
        .lifetime(.single)

        self.container.register(LocalSettings.init)
            .as(Settings.self)
            .lifetime(.single)

        // Gateways
        self.container.register(SignInGatewayImp.init)
            .as(SignInGateway.self)
            .lifetime(.single)

        self.container.register(SignUpGatewayImp.init)
            .as(SignUpGateway.self)
            .lifetime(.single)

//        self.container.register(GetPhotoGatewayImp.init)
//            .as(GetPhotoGateway.self)
//            .lifetime(.single)

        self.container.register(ApiPhotoPaginationGateway.init)
            .as(PaginationGateway.self)
            .lifetime(.single)

        self.container.register(PostPhotoGatewayImp.init)
            .as(PostPhotoGateway.self)
            .lifetime(.single)

        self.container.register(GetUserGatewayImp.init)
            .as(GetUserGateway.self)
            .lifetime(.single)

        self.container.register(GetCurrentUserGatewayImp.init)
            .as(GetCurrentUserGateway.self)
            .lifetime(.single)

        self.container.register(ChangePasswordGatewayImp.init)
            .as(ChangePasswordGateway.self)
            .lifetime(.single)

        self.container.register(ChangeUserInfoGatewayImp.init)
            .as(ChangeUserInfoGateway.self)
            .lifetime(.single)

        self.container.register(DeleteUserGatewayImp.init)
            .as(DeleteUserGateway.self)
            .lifetime(.single)

        // UseCases
        self.container.register(SignUpUseCaseImp.init)
            .as(SignUpUseCase.self)

        self.container.register(SignInUseCaseImp.init)
            .as(SignInUseCase.self)

//        self.container.register(GetPhotoUseCaseImp.init)
//            .as(GetPhotoUseCase.self)

        self.container.register(PaginationUseCaseImp.init)
            .as(PaginationUseCase.self)

        self.container.register(PostPhotoUseCaseImp.init)
            .as(PostPhotoUseCase.self)

        self.container.register(GetUserUseCaseImp.init)
            .as(GetUserUseCase.self)

        self.container.register(GetCurrentUserUseCaseImp.init)
            .as(GetCurrentUserUseCase.self)

        self.container.register(ChangePasswordUseCaseImp.init)
            .as(ChangePasswordUseCase.self)

        self.container.register(ChangeUserInfoUseCaseImp.init)
            .as(ChangeUserInfoUseCase.self)

        self.container.register(DeleteUserUseCasImp.init)
            .as(DeleteUserUseCase.self)
        
    }

    static func resolve<T>() -> T {
        return self.container.resolve()
    }
}
