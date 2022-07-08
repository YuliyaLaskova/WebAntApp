//
//  PaginationEntity.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 30.06.2022.
//

import Foundation

class PaginationEntity<T: Codable>: Codable {

    var totalItems: Int
    var itemsPerPage: Int
    var countOfPages: Int
    var data: [T]

    init(totalItems: Int, itemsPerPage: Int, countOfPages: Int, items: [T]) {
        self.totalItems = totalItems
        self.itemsPerPage = itemsPerPage
        self.countOfPages = countOfPages
        self.data = items
    }
}
