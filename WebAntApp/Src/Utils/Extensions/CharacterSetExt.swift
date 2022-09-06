//
//  CharacterSetExt.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 04.08.2022.
//

import Foundation

extension CharacterSet {
    static var passwordAllowedSet: CharacterSet {
        let upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lower = "abcdefghijklmnopqrstuvwxyz"
        let digits = "0123456789"
        let symbols = "._"
        return .init(charactersIn: upper + lower + digits + symbols)
    }
}
