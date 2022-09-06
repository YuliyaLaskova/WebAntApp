//
//  BaseView.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.07.2022.
//

import Foundation
import UIKit

protocol BaseView: AnyObject {
//    func startActivityIndicator(at view: UIViewController)
//    func stopActivityIndicator(at view: UIViewController)
}

extension BaseView {
//    func startActivityIndicator(at view: UIViewController) {
//        view.setupActivityIndicator()
//    }
//
//    func stopActivityIndicator(at view: UIViewController) {
//        view.removeActivityIndicator()
//    }

    func addInfoModuleWithFunc(alertTitle: String,
                           alertMessage: String?,
                           buttonMessage: String,
                           completion: (() -> Void)? = nil)  {
        guard let view = (self as? UIViewController) else { return }

        Alerts().addAlert(alertTitle: alertTitle,
                          alertMessage: alertMessage,
                          buttonMessage: buttonMessage,
                          view: view,
                          function: completion)
    }
}


class Alerts {

    func addAlert(alertTitle: String,
                  alertMessage: String?,
                  buttonMessage: String,
                  view: UIViewController,
                  function: (() -> Void)? = nil) {

        let alert = UIAlertController(title: alertTitle,
                                      message: alertMessage,
                                      preferredStyle: .alert)
        var button = UIAlertAction(title: buttonMessage,
                                   style: .cancel,
                                   handler: nil)
        if function != nil {
            button =  UIAlertAction(title: buttonMessage,
                                    style: .cancel) {
                (action) -> Void in
                function?()
            }
        }

        alert.addAction(button)
        view.modalPresentationStyle = .overCurrentContext
        view.present(alert, animated: true, completion: nil)
    }
}
