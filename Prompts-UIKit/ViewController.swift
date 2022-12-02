//
//  ViewController.swift
//  Prompts-UIKit
//
//  Created by Vishal Dubey on 12/2/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var givenNameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var loginButton: LoadingButton!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var isSubmitting: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.setupButton()
        
        self.givenNameField.delegate = self
        self.usernameField.delegate = self
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        resetErrorMessage()
        
        guard let enteredUsername = usernameField.text,
              let enteredGivenName = givenNameField.text,
              !self.isSubmitting else {
            return
        }
        
        self.isSubmitting = true
        loginButton.showLoading()
        Account.login(username: enteredUsername, givenName: enteredGivenName) { result in
            self.loginButton.hideLoading()
            self.isSubmitting = false
            switch result {
            case .success(let success):
                if success {
                    self.performSegue(withIdentifier: "successLogin", sender: nil)
                    return
                } else {
                    let error = RuntimeError(message: "Invalid login credentials provided", error: "InvalidCredentials")
                    self.errorMessageLabel.text = error.message
                    return
                }
            case .failure(let failure):
                let error = RuntimeError(message: "Sorry, we are unable to log you in at this time", error: failure)
                self.errorMessageLabel.text = error.message
                return
            }
        }
    }
    
    func resetErrorMessage() {
        self.errorMessageLabel.text = ""
    }
    
}


