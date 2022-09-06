//
//  CustomActivityIndicatorView.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 27.07.2022.
//

import Foundation
import UIKit

class CustomActivityIndicatorView: UIView {

    let spinningCircle = CAShapeLayer()

    override init(frame:CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configure()
    }

    private func configure() {
        let rect = self.bounds
        let circularPath = UIBezierPath(ovalIn: rect)

        spinningCircle.path = circularPath.cgPath
        spinningCircle.fillColor = UIColor.clear.cgColor
        spinningCircle.strokeColor = UIColor.systemGray3.cgColor
        spinningCircle.lineWidth = 10
        spinningCircle.strokeEnd = 0.75
        spinningCircle.lineCap = .round

        self.layer.addSublayer(spinningCircle)
    }

    func animate() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(rotationAngle: .pi)
        }) { (completed) in
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                self.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: nil)
        }
    }

    func stopAnimate() {
                self.subviews.forEach({$0.layer.removeAllAnimations()})
                self.layer.removeAllAnimations()
                self.layoutIfNeeded()
    }
}
