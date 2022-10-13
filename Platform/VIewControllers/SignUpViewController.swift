//
//  SignUpViewController.swift
//  Platform
//
//  Created by Kareem Shabaka on 4/26/20.
//  Copyright © 2020 Kareem Shabaka. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class SignUpViewController: UIViewController {

    let stackView = UIStackView()
    
    let firstName = UITextField()
    let lastName = UITextField()
    let emailText = UITextField()
    let passwordText = UITextField()
    let errorLabel = UILabel()
    let createAccountButton = UIButton()
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
           createStackView()
           popStackView()
           view.backgroundColor = .white
       
       
       }
    
    private func createStackView() {
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        }
    
    private func popStackView() {
        
        firstName.placeholder = "First Name"
        lastName.placeholder = "Last Name"
        emailText.placeholder = "Email"
        passwordText.placeholder = "Password"
        createAccountButton.setTitle("Sign Up", for: .normal)
        
        firstName.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 80 , height: 30 )
        lastName.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 80 , height: 30 )
        emailText.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 80 , height: 30 )
        passwordText.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 80 , height: 30 )
        
        passwordText.isSecureTextEntry = true
        
        errorLabel.alpha = 0
        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
               
        Utilities.styleTextField(firstName)
        Utilities.styleTextField(lastName)
        Utilities.styleTextField(emailText)
        Utilities.styleTextField(passwordText)
        Utilities.styleFilledButton(createAccountButton)
               
        
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(firstName)
        stackView.addArrangedSubview(lastName)
        stackView.addArrangedSubview(emailText)
        stackView.addArrangedSubview(passwordText)
        stackView.addArrangedSubview(createAccountButton)
        
        createAccountButton.addTarget(self, action: #selector(self.createAccountTapped), for: .touchUpInside)
        
    }
    
    
    final func configureStackView() {
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
    }
    
   
    
    
    
    func validateFields() -> String? {
        
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
       
            return "Please fill in all the fields"
    }
        
        return nil
    }
    
    @objc func createAccountTapped(_ sender: Any) {
    
        let error = validateFields()
        
        if error != nil {
            
        showError(error!)
            
        }
        
        else {
            
            let first = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let last = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                
                if error != nil {
                    self.showError("Error creating user")
                    
                } else {
                    
                    let db = Firestore.firestore()
                    
                    db.collection("users").document("\(result!.user.uid)").setData(["firstname":first, "lastname":last], completion: { (error) in
                        if error != nil {
                            print("Error saving user data")
                        }
                    })
                    
                    self.transitiontoHome()
                }
                
            }
            
        }
        
    }
    
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    

    final func transitiontoHome() {
        
        view.window?.rootViewController = TabController()
        view.window?.makeKeyAndVisible()
        
    }

   
    


}
