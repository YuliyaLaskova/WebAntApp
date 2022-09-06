//
//  SignInController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.06.2022.
//

import UIKit

class SignInViewController: UIViewController {
    var presenter: SignInPresenter?
    // MARK: IB Outlets
    @IBOutlet var signInBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet var loginTextField: DesignableUITextField!
    @IBOutlet var passwordTextField: DesignableUITextField!
    @IBOutlet var signInLabelTopCnstr: NSLayoutConstraint!
    @IBOutlet var loginStackTopCnstr: NSLayoutConstraint!
    @IBOutlet var signInUpStackTopCnstr: NSLayoutConstraint!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupLeftNavigationBarButton(title: R.string.scenes.cancel(), selector: #selector(goBack))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.setupLeftNavigationBarButton(title: R.string.scenes.cancel(), selector: #selector(goBack))
// TODO: сделать свойсвто ХИДДЕН и скрывать бар
    }
    // MARK: Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.orientation.isPortrait {
            signInLabelTopCnstr.constant = 140
            loginStackTopCnstr.constant = 50
            signInUpStackTopCnstr.constant = 50

            view.layoutIfNeeded()
        }
        else if UIDevice.current.orientation.isLandscape {
            signInLabelTopCnstr.constant = 50
            loginStackTopCnstr.constant = 20
            signInUpStackTopCnstr.constant = 20
            view.layoutIfNeeded()
        }
    }
    // MARK: Setup UI method
    private func setupUI() {
        setupTextFieldsDelegate()
        signInBtn.layer.cornerRadius = 4
        signUpBtn.layer.cornerRadius = 4
        signUpBtn.layer.borderWidth = 1

        guard let emailIconImage = R.image.emailIcon() else { return }
        loginTextField.rightImage = emailIconImage

        passwordTextField.rightButton = UIButton()
    }

    // MARK: IB Actions
    @IBAction func signInBtnPressed() {
        view.endEditing(true)
        self.validateTextFieldsAndProceed()
    }

    @IBAction func signUpBtnPressed() {
        openSignUpScene()
    }

    //    func setupNavigationBarItem() {
    //        self.navigationController?.setNavigationBarHidden(false, animated: false)
    //        let cancelButton = UIBarButtonItem.init(
    //            title: "Cancel",
    //            style: .done,
    //            target: self,
    //            action: #selector(goBack)
    //        )
    //        self.navigationItem.leftBarButtonItem = cancelButton
    //        cancelButton.tintColor = .gray
    //    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
