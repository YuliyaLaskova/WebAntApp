//
//  MediaObjectEntity.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 24.06.2022.
//

import Foundation
import RxNetworkApiClient

class MediaObjectEntity: JsonBodyConvertible, Codable {

    var id: Int?
    var name: String?

    init(id: Int?, name: String?) {
        self.name = name
        self.id = id
    }
}
