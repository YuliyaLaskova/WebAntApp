//
//  PhotoEntity.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 23.06.2022.
//

import Foundation
import RxNetworkApiClient

struct PhotoModel: JsonBodyConvertible, Codable {
    var totalItems: Int
    var data: [GetPhotoEntity]
}

class GetPhotoEntity: JsonBodyConvertible, Codable {

    var name: String?
    var dateCreate: String?
    var description: String?
    var new: Bool
    var popular: Bool
    var image: Image?

    init(name: String?, dateCreate: String?, description: String?, new: Bool, popular: Bool ) {
        self.name = name
        self.dateCreate = dateCreate
        self.description = description
        self.new = new
        self.popular = popular
    }

    struct Image: JsonBodyConvertible, Codable {
        var id: Int?
        var name: String?
    }
}

