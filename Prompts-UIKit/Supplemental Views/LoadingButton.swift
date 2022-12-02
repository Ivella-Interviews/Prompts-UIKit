//
//  LoadingButton.swift
//  Prompts-UIKit
//
//  Created by Vishal Dubey on 12/2/22.
//

import Foundation
import UIKit

class LoadingButton: UIButton {
    private var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    func setupButton() {
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func enable() {
        self.isUserInteractionEnabled = true
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.titleLabel?.textColor = UIColor.systemBlue
    }
    
    func disable() {
        self.isUserInteractionEnabled = false
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.titleLabel?.textColor = UIColor.systemGray
    }

    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }

    func hideLoading() {
        self.setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .lightGray
        return activityIndicator
    }

    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }

    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
