//
//  ModelViewAlert.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 29.07.2022.
//

import Foundation
import UIKit

class ModelAlertViewController: UIViewController {

    private var modelSuperView = UIView()

     func setupModel() {

         let iconView = UIView()
         var iconImage = UIImageView()
         let successLabel = UILabel()

         view.addSubview(modelSuperView)
         modelSuperView.addSubview(iconView)
         iconView.addSubview(iconImage)

         modelSuperView.translatesAutoresizingMaskIntoConstraints = false
         modelSuperView.heightAnchor.constraint(equalToConstant: 50).isActive = true
         modelSuperView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
         modelSuperView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
         modelSuperView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
         modelSuperView.layer.cornerRadius = 5
         modelSuperView.backgroundColor = .gray

         iconView.translatesAutoresizingMaskIntoConstraints = false
         let width: CGFloat = 20
         iconView.heightAnchor.constraint(equalToConstant: 20).isActive = true
         iconView.widthAnchor.constraint(equalToConstant: width).isActive = true
         iconView.leftAnchor.constraint(equalTo: modelSuperView.leftAnchor, constant: 17).isActive = true
         iconView.topAnchor.constraint(equalTo: modelSuperView.topAnchor, constant: 14).isActive = true
         iconView.backgroundColor = .white
         iconView.layer.cornerRadius = width / 2

         iconImage.translatesAutoresizingMaskIntoConstraints = false
         iconImage.topAnchor.constraint(equalTo: iconView.topAnchor, constant: 3).isActive = true
         iconImage.bottomAnchor.constraint(equalTo: iconView.bottomAnchor, constant: -3).isActive = true
         iconImage.leftAnchor.constraint(equalTo: iconView.leftAnchor, constant: 3).isActive = true
         iconImage.rightAnchor.constraint(equalTo: iconView.rightAnchor, constant: -3).isActive = true
         iconImage.backgroundColor = .gray
         let img = UIImage(named: "Info")
         iconImage = UIImageView(image: img)

         iconView.addSubview(iconImage)
         modelSuperView.addSubview(successLabel)

         successLabel.translatesAutoresizingMaskIntoConstraints = false
         successLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
         successLabel.widthAnchor.constraint(equalToConstant: 260).isActive = true
         successLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 13).isActive = true
         successLabel.topAnchor.constraint(equalTo: modelSuperView.topAnchor, constant: 16).isActive = true
         successLabel.textColor = .white
         successLabel.font = .systemFont(ofSize: 18)
         successLabel.text = R.string.scenes.successInPublicationMessage()
    }

    func showModel(finished: @escaping (() -> Void) ) {
        modelSuperView.isHidden = false
        setupModel()
       _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { [weak self] _ in self?.modelSuperView.isHidden = true
           finished()
       })
    }
}
