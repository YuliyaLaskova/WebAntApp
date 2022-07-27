//
//  AddDataView.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

protocol AddDataView: AnyObject {
    // func Photo(_ image: UIImage, PhotoEntityForPost)
    func addPressed()    
}

extension AddDataView {

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
