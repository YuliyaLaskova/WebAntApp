//
//  PhotoPostEntity.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 24.06.2022.
//

import Foundation
import RxNetworkApiClient

class PostPhotoEntity: JsonBodyConvertible, Codable {

    var name: String?
    var dateCreate: String?
    var description: String?
    var new: Bool
    var popular: Bool

    init(name: String?, dateCreate: String?, description: String?, new: Bool, popular: Bool ) {
        self.name = name
        self.dateCreate = dateCreate
        self.description = description
        self.new = new
        self.popular = popular
    }
}

