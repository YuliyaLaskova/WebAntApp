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
    var new: String?
    var popular: String?
    var image: String?

    init(name: String?, description: String?, new: String?, popular: String?, image: Int?) {
        self.name = name
        self.description = description
        // self.popular = new   self.new = popular или наоборот?
        self.popular = new
        self.new = popular
        self.image = "/api/media_objects/\(image ?? 0)"
    }
}

