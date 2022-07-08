//
//  PaginationGateway.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 30.06.2022.
//

import Foundation
import RxSwift

protocol PaginationGateway {
    func getPhotos(_ page: Int, _ limit: Int) -> Single<PaginationEntity<PhotoEntityForGet>>
}

