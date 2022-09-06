//
//  TableConfigurator.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 19.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum TableConfigurator {
    
    static func configure(view: TableViewController) {
        let router = TableRouter(view)
        let presenter = TablePresenterImp(view, router)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.tableStoryboard().instantiateInitialViewController()  as? TableViewController else {
            return
        }
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
