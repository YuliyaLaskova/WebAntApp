//
// Created by admin on 10.08.2018.
// Copyright (c) 2018 WebAnt. All rights reserved.
//

import Foundation


public protocol JsonBodyConvertible: BodyConvertible, Codable {

    var jsonEncoder: JSONEncoder { get }
}


public extension JsonBodyConvertible {

    var jsonEncoder: JSONEncoder {
        return JSONEncoder()
    }

    func createBody() -> Data {
        return try! jsonEncoder.encode(self)
    }
}
