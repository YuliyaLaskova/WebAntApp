//
//  MainGalleryViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 21.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class MainGalleryViewController: UIViewController {
    
    var presenter: MainGalleryPresenter?

    private let refreshControl = UIRefreshControl()
    private let searchBar = UISearchBar()

    @IBOutlet var imageCollection: UICollectionView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var errorImage: UIImageView!

    @IBOutlet var newPopularSegCntrl: CustomSegmentedControl!{
        didSet{
            newPopularSegCntrl.setButtonTitles(buttonTitles: ["New","Popular"])
            newPopularSegCntrl.selectorViewColor = .systemPink
            newPopularSegCntrl.selectorTextColor = .black
            newPopularSegCntrl.backgroundColor = .white
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if presenter == nil {
            MainGalleryConfigurator.configure(view: self)
        }
        presenter?.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {

        errorImage.isHidden = true

        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = R.string.scenes.searchCase()
        searchBar.searchTextField.addDoneButtonOnKeyboard()

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .gray

        imageCollection.delegate = self
        imageCollection.dataSource = self
        newPopularSegCntrl.delegate = self

        imageCollection.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefreshPhotos) , for: .valueChanged)

        let layout = UICollectionViewFlowLayout()

//        let width: CGFloat = ((view.frame.size.width - 37) / 2)
        let width: CGFloat = ((view.frame.size.width / 2) - 20)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        imageCollection.collectionViewLayout = layout
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.orientation.isPortrait {
            let layout = UICollectionViewFlowLayout()
            let width: CGFloat = ((view.frame.size.width / 2) - 20)
            layout.itemSize = CGSize(width: width, height: width)
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
            imageCollection.collectionViewLayout = layout

            view.layoutIfNeeded()
        }

        else if UIDevice.current.orientation.isLandscape {
            let layout = UICollectionViewFlowLayout()
            let width: CGFloat = ((view.frame.size.width / 4) - 40)
            layout.itemSize = CGSize(width: width, height: width)
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
            imageCollection.collectionViewLayout = layout
            view.layoutIfNeeded()
        }
    }

//            if UIDevice.current.orientation.isPortrait, let layout = imageCollection.collectionViewLayout as? UICollectionViewFlowLayout {
//
//                let width: CGFloat = ((view.frame.size.width / 2) - 20)
//                layout.itemSize = CGSize(width: width, height: width)
//                layout.minimumInteritemSpacing = 5
//                layout.minimumLineSpacing = 5
//                layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
//            }
//
//            else if UIDevice.current.orientation.isLandscape, let layout = imageCollection.collectionViewLayout as? UICollectionViewFlowLayout {
//
//                let width: CGFloat = ((view.frame.size.width / 4) - 40)
//                layout.itemSize = CGSize(width: width, height: width)
//                layout.minimumInteritemSpacing = 5
//                layout.minimumLineSpacing = 5
//                layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
//            }
//        }

    @objc func pullToRefreshPhotos() {
        presenter?.refreshPhotos(photoIndex: newPopularSegCntrl.selectedIndex, needToLoadPhotos: true)
    }
}

extension MainGalleryViewController: MainGalleryView {

    func showErrorOnEmptyGallery(show: Bool) {
        switch show {
        case true:
            errorImage.isHidden = false
        default:
            errorImage.isHidden = true
        }
    }

    func refreshPhotoCollection() {
        imageCollection.reloadData()
    }

    func actIndicatorStartAnimating() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func actIndicatorStopAnimating() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}

extension MainGalleryViewController: CustomSegmentedControlDelegate  {
    func change(to index: Int) {
        searchBar.text = ""
        switch index {
        case 0:
            imageCollection.setContentOffset(CGPoint(x: 0, y: presenter?.currentStateOfNewCollection ?? 0), animated: false)
            presenter?.fetchNewPhotosWithPagination(imageName: nil)
        case 1:
            imageCollection.setContentOffset(CGPoint(x: 0, y: presenter?.currentStateOfPopularCollection ?? 0), animated: false)
            presenter?.fetchPopularPhotosWithPagination(imageName: nil)
        default:
            break
        }
        refreshPhotoCollection()
        print("segmentedControl index changed to \(index)")
    }
}


// content offset
extension MainGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource  {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0}

        switch newPopularSegCntrl.selectedIndex {
        case 0: if presenter.newPhotoArray.count > 0 {
            showErrorOnEmptyGallery(show: false)
            return presenter.newPhotoArray.count
        } else {
            showErrorOnEmptyGallery(show: true)
            return 0
        }
        default:
            if presenter.popularPhotoArray.count > 0 {
                showErrorOnEmptyGallery(show: false)
                return presenter.popularPhotoArray.count
            } else {
                showErrorOnEmptyGallery(show: true)
                return 0
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as? PhotoCell {
            switch newPopularSegCntrl.selectedIndex {
            case 0:
                guard let photo = presenter?.newPhotoArray[indexPath.row].image?.name else {
                    return UICollectionViewCell()
                }
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 10
                cell.setupImage(photo)
                return cell
            case 1:
                guard let photo = presenter?.popularPhotoArray[indexPath.row].image?.name else {
                    return UICollectionViewCell()
                }
                //            if let photo = presenter?.photoItems[indexPath.row].image {
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 10
                cell.setupImage(photo)
                return cell
            default:
                return UICollectionViewCell()
            }

            //            guard let photo = presenter?.photoItems[indexPath.row].image?.name else {
            //                return UICollectionViewCell()
            //            }
            //            if let photo = presenter?.photoItems[indexPath.row].image {
            //            cell.clipsToBounds = true
            //            cell.layer.cornerRadius = 10
            //            cell.setupImage(photo)
            //            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.openDetailedPhoto(photoIndex: indexPath.row, newPopularSegCntrlIndex: newPopularSegCntrl.selectedIndex)
        print("you tapped item at index \(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.presenter!.newPhotoArray.count - 1 {
            self.presenter?.fetchNewPhotosWithPagination(imageName: nil)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch newPopularSegCntrl.selectedIndex {
        case 0:
            presenter?.currentStateOfNewCollection = scrollView.contentOffset.y
        case 1:
            presenter?.currentStateOfPopularCollection = scrollView.contentOffset.y
        default:
            break
        }
    }
}

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

//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//            self.searchBar.showsCancelButton = true
//    }

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
