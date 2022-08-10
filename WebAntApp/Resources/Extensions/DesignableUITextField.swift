//
//  DesignableUITextField.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.06.2022.
//

import Foundation
import UIKit

//@IBDesignable
class DesignableUITextField: UITextField, UITextFieldDelegate {

    var errorLabel: UILabel?

    // Provides right padding for images
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }

    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }

    var rightButton: UIButton? {
        didSet {
            updateViewWithButton()

        }
    }

    func addErrorLabelToTextField(needToShowLabel: Bool, withText: String?, superView: UIView) {
        errorLabel?.removeFromSuperview()
        if needToShowLabel == true {
            errorLabel = UILabel()
            superView.addSubview(errorLabel ?? UILabel())
            errorLabel?.translatesAutoresizingMaskIntoConstraints = false
            errorLabel?.heightAnchor.constraint(equalToConstant: 15).isActive = true
            errorLabel?.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            errorLabel?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
            errorLabel?.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            errorLabel?.font = errorLabel?.font.withSize(12)
            errorLabel?.textColor = .red
            errorLabel?.text = withText
            errorLabel?.isHidden = false
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.cornerRadius = 5
        } else {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.systemGray5.cgColor
            self.layer.cornerRadius = 5
            errorLabel?.removeFromSuperview()
        }
    }
    // сделать кастомн класс от юфшвью и там два свойства текст филд и ерор лэбл

    @IBInspectable var rightPadding: CGFloat = 0

    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }

    func updateView() {
        if let image = rightImage {
            rightViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            rightView = imageView
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }

        //         Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }

    private func updateViewWithButton() {
        if let _ = rightButton {
            rightViewMode = .always
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            button.setImage(R.image.eyeIcon(), for: .normal)
            button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
            rightView = button
        }

        else {
            rightViewMode = .never
            rightView = nil
        }

    }

    @objc func rightButtonTapped() {
        self.isSecureTextEntry = !self.isSecureTextEntry
    }
}
