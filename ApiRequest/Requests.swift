//
//  Requests.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 14.06.2022.
//

import Foundation

import RxNetworkApiClient
import RxSwift

// swiftlint:disable file_length superfluous_disable_command

extension ExtendedApiRequest {

    public static func signIn(login: String, password: String) -> ExtendedApiRequest {
        return extendedRequest(path: "/oauth/v2/token",
                               method: .get,
                               query: ("client_id", Config.clientId),
                               ("grant_type", "password"),
                               ("username", login),
                               ("password", password),
                               ("client_secret", Config.clientSecret))

    }

    static func signUp(userEntity: UserEntity) -> ExtendedApiRequest {
        return extendedRequest(
            path: "/api/users",
            method: .post,
            headers: [Header.contentJson],
            body: userEntity)

    }

    static func postMediaObject(file: UploadFile) -> ExtendedApiRequest {
        return extendedRequest(
            path: "/api/media_objects",
            method: .post,
            headers: [Header.contentJson],
            files: [file])
    }

    static func postPhoto(photo: PostPhotoEntity) -> ExtendedApiRequest {
        return extendedRequest(
            path: "/api/photos",
            method: .post,
            headers: [Header.contentJson]
        )
    }

    static func getPhoto() -> ExtendedApiRequest {
            extendedRequest(
                path: "/api/photos",
                method: .get,
                headers: [Header.contentJson]
            )
        }

}
