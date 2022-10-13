//
//  EditProfileViewController.swift
//  Platform
//
//  Created by Kareem Shabaka on 5/10/20.
//  Copyright © 2020 Kareem Shabaka. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    let fname = UserDefaults.standard.string(forKey: "fname")
    let lname = UserDefaults.standard.string(forKey: "lname")
    
    
    let firstText: UITextField = {
        let ftext = UITextField()
        ftext.translatesAutoresizingMaskIntoConstraints = false
        
        return ftext
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        configureUI()
    }
    
    func configureUI() {
        
        //navigationController?.
        
        
        
        view.addSubview(firstText)
        firstText.placeholder = fname!
        firstText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        firstText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
    }
    
    
    
  

}
