//
//  SettingsPresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import RxSwift

class SettingsPresenterImp: SettingsPresenter {
    private weak var view: SettingsView?
    private let router: SettingsRouter
    private var currentUser: UserEntityForGet?
    var currentUserEntity: UserEntity?
    private var getCurrentUserUseCase: GetCurrentUserUseCase
    private var changePasswordUseCase: ChangePasswordUseCase
    private var changeUserInfoUseCase: ChangeUserInfoUseCase
    private var deleteUserUseCase: DeleteUserUseCase
    var settings: Settings
    var disposeBag = DisposeBag()

    init(view: SettingsView,
         router: SettingsRouter, settings: Settings, getCurrentUserUseCase: GetCurrentUserUseCase, changePasswordUseCase: ChangePasswordUseCase, changeUserInfoUseCase: ChangeUserInfoUseCase, deleteUserUseCase: DeleteUserUseCase) {
        self.view = view
        self.router = router
        self.settings = settings
        self.getCurrentUserUseCase = getCurrentUserUseCase
        self.changePasswordUseCase = changePasswordUseCase
        self.changeUserInfoUseCase = changeUserInfoUseCase
        self.deleteUserUseCase = deleteUserUseCase
    }

    func viewDidLoad() {
        getCurrentUserFromAPI()
    }

    func getCurrentUserFromAPI() {
        getCurrentUserUseCase.getCurrentUser()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] returningUser in
                self?.currentUser = returningUser
                self?.view?.setupUser(user: returningUser)
            }, onFailure: { error in
                print("@@@ error\(error)")
            })
            .disposed(by: disposeBag)
    }

    func getCurrentUser() -> UserEntityForGet? {
        currentUser
    }

    func changeUserPassword(oldPassword: String, newPassword: String) {
        let userPass = ChangePasswordEntity(oldPassword: oldPassword, newPassword: oldPassword)
        changePasswordUseCase.updatePassword(currentUser?.id, userPass)
            .observe(on: MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                print("password is updated")
                //показывать модалку на успех
            }, onError: { error in
                //показывать модалку на фэйл
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }

    // TODO: вынести активити индикатор в отдельный класс, возможно в baseview, и закинуть его на все места где идет загрузка и показывать модалки на фэйл
    func changeUserInfo() {
        //        let user = UserEntity()
        guard let user = currentUserEntity else { return }
        self.changeUserInfoUseCase.updateUserInfo(currentUser?.id, user)
            .subscribe(on: MainScheduler.instance)
            .do(onSubscribe: { //[weak view = self.view] in
                //                        view?.showActivityIndicator()
            },
                onDispose: { //[weak view = self.view] in
                //                        view?.hideActivityIndicator()
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else {
                    return
                }
                //показывать модалку на успех
            },
                       onError: { error in
                //показывать модалку на фэйл
                print(error.localizedDescription)
            })
                .disposed(by: disposeBag)
                }

    func deleteUserAccount() {
        deleteUserUseCase.deleteUser()
            .do(onSubscribe: {
                self.view?.startActivityIndicator()},
                                onDispose: { self.view?.stopActivityIndicator() }   )
                //            }, onDispose: { self.router.goToWelcomeScene() })
                .observe(on: MainScheduler.instance)
                .subscribe(onCompleted: {
                    //
                    self.view?.stopActivityIndicator()
                    self.view?.addInfoModuleWithFunc(alertTitle: R.string.scenes.accountIsDeleted(), alertMessage: nil, buttonMessage: R.string.scenes.okAction(), completion: { [ weak self ] in
                        self?.settings.clearUserData()
                        self?.view?.stopActivityIndicator()
                        self?.router.goToWelcomeScene()
                    })
                    //                    self.view?.addInfoModuleWithFunc(alertTitle: R.string.scenes.accountIsDeleted(),
                    //                                                            alertMessage: nil,
                    //                                                            buttonMessage: R.string.scenes.okAction(),
                    //                                                            completion: { [ weak self ] in
                    //                                                                self?.settings.clearUserData()
                    ////                                                                self?.changeRootView()
                    //                                                            })
                }, onError: { [weak self] error in
                    self?.view?.stopActivityIndicator()
                    //                            guard error is ResponseErrorEntity else { return }
                    guard let self = self else { return }
                    self.view?.addInfoModuleWithFunc(alertTitle: R.string.scenes.error(),
                                                     alertMessage: error.localizedDescription,
                                                     buttonMessage: R.string.scenes.okAction(),
                                                     completion: {
                        [ weak self ] in
                            self?.view?.stopActivityIndicator()
                    })

                })
                .disposed(by: disposeBag)
                }
}
