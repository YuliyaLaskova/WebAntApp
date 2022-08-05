//
//  BaseView.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.07.2022.
//

import Foundation
import UIKit

protocol BaseView: AnyObject {
    
}

extension BaseView {
//    func setInfoModule() {
//        let modalView = UIView()
//        modalView.translatesAutoresizingMaskIntoConstraints = false
////        modalView.widthAnchor = 343
//        modalView.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        modalView.bottomAnchor.constraint(equalTo: .bottomAnchor, constant: 10)
//
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
//                self.makeFunc(action: function)
//                self.selfFunc?()
            }
        }

        alert.addAction(button)
        view.modalPresentationStyle = .overCurrentContext
        view.present(alert, animated: true, completion: nil)
    }
}
