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
    var data: [PhotoEntityForGet]

    init(totalItems: Int, itemsPerPage: Int, countOfPages: Int, items: [PhotoEntityForGet]) {
        self.totalItems = totalItems
        self.itemsPerPage = itemsPerPage
        self.countOfPages = countOfPages
        self.data = items
    }
}
