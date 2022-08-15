//
//  WelcomeVCExtensions.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 12.08.2022.
//

import Foundation

extension WelcomeController: WelcomeView {
    func openSignInScene() {
        presenter?.openSignInScene()
    }
    func openSignUpScene() {
        presenter?.openSignUpScene()
    }
}
