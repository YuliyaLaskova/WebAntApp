//
//  UIViewController+NavigationBar.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 18.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    //    func setRightNavBarButtonView(title: String ,target: Any, selector: Selector) {
    //            let button = UIButton(type: .custom)
    //            button.setTitle(title, for: .normal)
    //            button.setTitleColor(R.color.appPink(), for: .normal)
    //            button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 15)
    //            button.addTarget(target, action: selector, for: .touchUpInside)
    //            let barButton = UIBarButtonItem(customView: button)
    //            self.navigationItem.rightBarButtonItem = barButton
    //        }

    func setupLeftNavigationBarButton(
        title: String,
        isBackButtonHidden: Bool = false,
        isNavBarHidden: Bool = false,
        selector: Selector?
    ) {
        let cancelButton = UIBarButtonItem.init(
            title: title,
            style: .done,
            target: self,
            action: selector
        )
        self.navigationItem.leftBarButtonItem = cancelButton
        cancelButton.tintColor = .gray

        if isBackButtonHidden == true && title == "" {
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
            self.navigationItem.backBarButtonItem?.tintColor = .gray
        }
        self.navigationController?.isNavigationBarHidden = isNavBarHidden
    }
}

