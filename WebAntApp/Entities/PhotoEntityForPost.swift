//
//  PhotoPostEntity.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 24.06.2022.
//

import Foundation
import RxNetworkApiClient

class PhotoEntityForPost: JsonBodyConvertible, Codable {

    var name: String?
    var description: String?
    var new: Bool
    var popular: Bool
    var image: String?

    init(name: String?, description: String?, new: Bool, popular: Bool, image: Int?) {
        self.name = name
        self.description = description
        self.popular = Bool.random()
        self.new = !self.popular
        self.image = "/api/media_objects/\(image ?? 0)"
    }
}

