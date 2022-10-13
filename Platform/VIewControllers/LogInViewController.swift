//
//  LogInViewController.swift
//  Platform
//
//  Created by Kareem Shabaka on 4/26/20.
//  Copyright © 2020 Kareem Shabaka. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LogInViewController: UIViewController, UINavigationBarDelegate{

    let stackView = UIStackView()
    let bottomContainer = UIStackView()
    
    let emailText = UITextField()
    let passwordText = UITextField()
    let errorLabel = UILabel()
    let loginButton = UIButton()
    
    let signUp = UIButton()
    let noAccount = UILabel()
    
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
        
        emailText.placeholder = "Email"
        passwordText.placeholder = "Password"
        loginButton.setTitle("Log In", for: .normal)
           
        errorLabel.alpha = 0
        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
                
        emailText.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 80 , height: 30 )
        passwordText.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 80 , height: 30 )
        passwordText.isSecureTextEntry = true
        
        
        Utilities.styleTextField(emailText)
        Utilities.styleTextField(passwordText)
        Utilities.styleFilledButton(loginButton)
        
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(emailText)
        stackView.addArrangedSubview(passwordText)
        stackView.addArrangedSubview(loginButton)
            
        loginButton.addTarget(self, action: #selector(self.loginTapped), for: .touchUpInside)
        signUp.addTarget(self, action: #selector(self.signUpTapped), for: .touchUpInside)
    
    }
    
    private func NoAccSignUp() {
        
        self.view.addSubview(bottomContainer)
        
        bottomContainer.addArrangedSubview(noAccount)
        bottomContainer.addArrangedSubview(signUp)
        
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bottomContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 7.0).isActive = true
        bottomContainer.axis = .horizontal
        bottomContainer.alignment = .fill
        bottomContainer.distribution = .fill
        bottomContainer.spacing = 3
        
        signUp.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        signUp.setTitleColor(.black, for: .normal)
        signUp.setTitle("Sign Up", for: .normal)
        noAccount.text = "Don't have an account?"
        
        
    }
    
    @objc func signUpTapped(_ sender: Any) {
        
        navigationController?.pushViewController(SignUpViewController(), animated: true)
        
    }
    
    @objc func loginTapped(_ sender: Any) {
        
        let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                
    
                self.errorLabel.alpha = 1
                if error!.localizedDescription == "The password is invalid or the user does not have a password."{
                    self.errorLabel.text = "The password is incorrect"
                }
                
            } else {
                
                self.view.window?.rootViewController = TabController()
                self.view.window?.makeKeyAndVisible()
                
                
            }
            
        }
        
    }
    
    
    final func setUpNavBar () {
      
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.topItem?.title = ""
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        createStackView()
        popStackView()
        NoAccSignUp()
        view.backgroundColor = .white
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
  


}
