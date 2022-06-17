//
//  BaseRouter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.06.2022.
//

import Foundation
import UIKit


protocol BaseRouter {

    var view: UIViewController? { get }
}

extension BaseRouter {

    func dismiss(completion: (() -> Void)? = nil) {
        guard let view = self.view else {
            return
        }

        view.dismiss(animated: true, completion: completion)
    }

    func pop(completion: (() -> Void)? = nil) {
        guard let view = self.view else {
            return
        }

        if let _ = completion {
            view.navigationController?.popViewController(animated: true)
        } else {
            view.navigationController?.popViewController(animated: true)
        }
    }

    func popViewControllerss(popViews: Int,
                             animated: Bool = true,
                             popToRootIfNeed: Bool = false) {
        guard let vcCount = view?.navigationController?.viewControllers.count else {
            return
        }
        if vcCount > popViews {
            guard let vc = view?.navigationController?.viewControllers[vcCount - popViews - 1] else {
            return
        }
            view?.navigationController?.popToViewController(vc, animated: animated)
        } else if popToRootIfNeed {
            view?.navigationController?.popToRootViewController(animated: animated)
        }
    }

    func popToRoot(animated: Bool = true) {
        guard let view = self.view else {
            return
        }

        view.navigationController?.popToRootViewController(animated: animated)
    }
}
