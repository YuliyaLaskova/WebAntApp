//
//  ViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 06.06.2022.
//

import UIKit

class WelcomeController: UIViewController {
    var presenter: WelcomePresenter?
    // MARK: IB Outlets
    @IBOutlet var createAccountButton: UIButton!
    @IBOutlet var haveAccountButton: UIButton!
    @IBOutlet var logoView: UIImageView!
    @IBOutlet var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet var createAccountBtnTopCnstr: NSLayoutConstraint!
    @IBOutlet var haveAccountBtnTopCnstr: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        WelcomeConfigurator.configure(view: self)
        setupUI()
    }

    // MARK: Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.orientation.isPortrait {
            logoTopConstraint.constant = 208
            createAccountBtnTopCnstr.constant = 40
            haveAccountBtnTopCnstr.constant = 10

            view.layoutIfNeeded()
        }

        else if UIDevice.current.orientation.isLandscape {
            logoTopConstraint.constant = 20
            createAccountBtnTopCnstr.constant = 20
            haveAccountBtnTopCnstr.constant = 20
            view.layoutIfNeeded()
        }
    }

    // MARK: Setup UI method
    private func setupUI() {
        createAccountButton.layer.cornerRadius = 4
        haveAccountButton.layer.cornerRadius = 4
        haveAccountButton.layer.borderWidth = 1
    }

    // MARK: IB Actions
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        openSignUpScene()
    }

    @IBAction func haveAccountBtnPressed() {
        openSignInScene()
    }
}

