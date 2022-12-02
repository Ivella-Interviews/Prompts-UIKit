//
//  ViewController.swift
//  Prompts-UIKit
//
//  Created by Vishal Dubey on 12/2/22.
//

import UIKit

class ViewController: UIViewController {
    
    var titleLabel: UILabel!
    var givenNameField: UITextField!
    var usernameField: UITextField!
    var errorMessageLabel: UILabel!
    var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView()
        view.backgroundColor = .white
        
        setupView()
    }

    func setupView() {
        titleLabel = UILabel()
        titleLabel.text = "Hi there. What's your name?"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 64),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 24)
        ])
        
        
        givenNameField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        givenNameField.textAlignment = .left
        givenNameField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        givenNameField.placeholder = "John Doe"
        
        NSLayoutConstraint.activate([
            givenNameField.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 40),
            givenNameField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 24)
        ])
        
        
        usernameField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        usernameField.textAlignment = .left
        usernameField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        usernameField.placeholder = "john_doe"
        
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: givenNameField.topAnchor, constant: 24),
            usernameField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 24)
        ])
        
    }

    var isSubmitting: Bool = false
    
    func login(completionHandler: @escaping (Error?) -> Void) {
        guard let enteredUsername = usernameField.text,
              let enteredGivenName = givenNameField.text,
              !self.isSubmitting else {
            return
        }
        
        self.isSubmitting = true
        Account.login(username: enteredUsername, givenName: enteredGivenName) { result in
            self.isSubmitting = false
            switch result {
            case .success(let success):
                if success {
                    completionHandler(nil)
                    return
                } else {
                    var error = RuntimeError(message: "Invalid login credentials provided", error: "InvalidCredentials")
                    self.errorMessageLabel.text = error.message
                    completionHandler(error)
                    return
                }
            case .failure(let failure):
                var error = RuntimeError(message: "Sorry, we are unable to log you in at this time", error: failure)
                self.errorMessageLabel.text = error.message
                completionHandler(error)
                return
            }
        }
    }
    
}


