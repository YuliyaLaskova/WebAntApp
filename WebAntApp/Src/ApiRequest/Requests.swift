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
    public static func signInRequest(login: String, password: String) -> ExtendedApiRequest {
        return extendedRequest(path: "/oauth/v2/token",
                               method: .get,
                               query: ("client_id", Config.clientId),
                               ("grant_type", "password"),
                               ("username", login),
                               ("password", password),
                               ("client_secret", Config.clientSecret))

    }

    static func signUpRequest(userEntity: UserEntity) -> ExtendedApiRequest {
        return extendedRequest(
            path: "/api/users",
            method: .post,
            headers: [Header.contentJson],
            body: userEntity)
    }

    static func postMediaObjectRequest(file: UploadFile) -> ExtendedApiRequest {
        return extendedRequest(
            path: "/api/media_objects",
            method: .post,
            files: [file])
    }

    static func postPhotoRequest(photo: PhotoEntityForPost) -> ExtendedApiRequest {
        return extendedRequest(
            path: "/api/photos",
            method: .post,
            headers: [Header.contentJson],
            body: photo
        )
    }

    static func getPhotoPaginatedRequest(_ page: Int, _ limit: Int, _ isNew: Bool, _ name: String? = nil) -> ExtendedApiRequest {
        if isNew {
            return extendedRequest(
                path: "/api/photos",
                method: .get,
                headers: [Header.contentJson],
                query: ("page", "\(page)"),
                ("limit", "\(limit)"),
                ("new", "true"),
                ( "name", name))
        } else {
            return extendedRequest(
                path: "/api/photos",
                method: .get,
                headers: [Header.contentJson],
                query: ("page", "\(page)"),
                ("limit", "\(limit)"),
                ("new", "false"),
                ("popular", "true"),
                ( "name", name))
        }
    }

    static func getUserInfoRequest(_ iriId: String) -> ExtendedApiRequest {
        extendedRequest(path: iriId,
                        method: .get,
                        headers: [Header.contentJson])
    }

    static func getCurrentUserRequest() -> ExtendedApiRequest {
        extendedRequest(path: "/api/users/current",
                        method: .get,
                        headers: [Header.contentJson])
    }

    static func getUserPhotosRequest(userId: Int) -> ExtendedApiRequest {
        extendedRequest(path: "/api/photos",
                        method: .get,
                        headers: [Header.contentJson],
                        query: ("user.id", "\(userId)"))
    }

    static func updateUserInfoRequest(userId: Int, user: UserEntity) -> ExtendedApiRequest {
           extendedRequest(path: "/api/users/\(userId)",
                           method: .put,
                           headers: [Header.contentJson],
                           body: user)
       }

    static func updatePasswordRequest(userId: Int, passwordEntity: ChangePasswordEntity) -> ExtendedApiRequest {
           extendedRequest(path: "/api/users/update_password/\(userId)",
                           method: .put,
                           headers: [Header.contentJson],
                           body: passwordEntity)
       }

    static func deleteUserRequest(userId: Int) -> ExtendedApiRequest {
           extendedRequest(path: "/api/users/\(userId)",
                           method: .delete)
       }
}
