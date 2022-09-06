//
//  ActivityIndicatorViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 11.08.2022.
//
import Foundation
import UIKit

extension UIViewController {
    
    struct Holder {
        static let activityIndicatorView = CustomActivityIndicatorView()
    }
    
    func setupActivityIndicator() {
        view.addSubview(Holder.activityIndicatorView)
        
        Holder.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        Holder.activityIndicatorView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        Holder.activityIndicatorView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        Holder.activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Holder.activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        Holder.activityIndicatorView.isHidden = false
        Holder.activityIndicatorView.animate()
    }
    
    func removeActivityIndicator() {
        Holder.activityIndicatorView.stopAnimate()
        Holder.activityIndicatorView.removeFromSuperview()
    }
}
