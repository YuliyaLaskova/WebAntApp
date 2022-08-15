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

extension UIViewController {

    /**
     Скрывает TabBar.
     - parameter hidden: Bool - Скрыть/Показать.
     - parameter animated: Bool - С анимацией, или без неё.
     - parameter duration: TimeInterval - Длительность анимации.
     */
    func setTabBarHidden(_ hidden: Bool, animated: Bool = true, duration: TimeInterval = 0.3) {
        if animated {
            if let frame = self.tabBarController?.tabBar.frame {
                let factor: CGFloat = hidden ? 1 : -1
                let y = frame.origin.y + (frame.size.height * factor)
                UIView.animate(withDuration: duration, animations: {
                    self.tabBarController?.tabBar.frame = CGRect(x: frame.origin.x,
                                                                 y: y,
                                                                 width: frame.width,
                                                                 height: frame.height)
                })
                return
            }
        }
        self.tabBarController?.tabBar.isHidden = hidden
    }
}
