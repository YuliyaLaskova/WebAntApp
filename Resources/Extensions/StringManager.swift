//
//  StringManager.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 15.06.2022.
//

import Foundation

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
