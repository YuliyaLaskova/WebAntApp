//
//  VC+SearchBar.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 09.08.2022.
//

import Foundation
import UIKit

extension MainGalleryViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        guard let imageName = searchBar.text else { return }
        presenter?.refreshPhotos(collectionType: newPopularSegmentedControl.selectedIndex, needToLoadPhotos: false)
        switch newPopularSegmentedControl.selectedIndex {
        case .new: presenter?.fetchNewPhotosWithPagination(imageName: imageName)
        case .popular: presenter?.fetchPopularPhotosWithPagination(imageName: imageName)
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            presenter?.refreshPhotos(collectionType: newPopularSegmentedControl.selectedIndex, needToLoadPhotos: true)
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter?.refreshPhotos(collectionType: newPopularSegmentedControl.selectedIndex, needToLoadPhotos: true)
        }
    }
}
