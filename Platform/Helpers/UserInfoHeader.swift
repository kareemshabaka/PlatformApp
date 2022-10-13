//
//  UserInfoHeader.swift
//  Platform
//
//  Created by Kareem Shabaka on 5/9/20.
//  Copyright © 2020 Kareem Shabaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class UserInfoHeader: UIView {
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser!.uid
    
    func downloadInfo() {
        
        let docRef = db.collection("users").document("\(userID)")
    
           docRef.getDocument { (snapshot, error) in
            
            if let err = error {
                print("\(err)")
            } else {
            
                let data = snapshot!.data()
                
                let fname = data?["firstname"] as? String ?? "An"
                let lname = data?["lastname"] as? String ?? "An"
                
                self.usernameLabel.text = "\(fname) \(lname)"
                
                UserDefaults.standard.set("\(fname)", forKey: "fname")
                UserDefaults.standard.set("\(lname)", forKey: "lname")
            }
        }
         
        let userEmail = Auth.auth().currentUser!.email
        
        emailLabel.text = "\(userEmail ?? "No Email")"
        
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        //iv.image = UIImage(named: "ironman")
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        downloadInfo()
        
        let profileImageDimension: CGFloat = 60
        
        addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.layer.cornerRadius = profileImageDimension / 2
        
        addSubview(usernameLabel)
        usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        
        
        
        addSubview(emailLabel)
        emailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

