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
        presenter?.refreshPhotos(photoIndex: newPopularSegCntrl.selectedIndex, needToLoadPhotos: false)
        switch newPopularSegCntrl.selectedIndex {
        case 0: presenter?.fetchNewPhotosWithPagination(imageName: imageName)
        case 1: presenter?.fetchPopularPhotosWithPagination(imageName: imageName)
        default: break
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            if searchBar.text == "" {
                presenter?.refreshPhotos(photoIndex: newPopularSegCntrl.selectedIndex, needToLoadPhotos: true)

            }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter?.refreshPhotos(photoIndex: newPopularSegCntrl.selectedIndex, needToLoadPhotos: true)
        }
    }
}
