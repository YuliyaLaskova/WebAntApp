//
//  DateManager.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 07.07.2022.
//

import Foundation

extension DateFormatter {

    static func formatter(dateFormat: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = dateFormat

        return formatter
    }

    static var defaultFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd.MM.yyyy"

        return formatter
    }

    static var humanFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd MMMM YYYY"

        return formatter
    }
}
