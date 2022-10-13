//
//  AppHandlerViewController.swift
//  Platform
//
//  Created by Kareem Shabaka on 4/27/20.
//  Copyright © 2020 Kareem Shabaka. All rights reserved.
//

import UIKit
import Firebase

class AppHandlerViewController: UIViewController {

    final func setRootViewController() {
        if Auth.auth().currentUser != nil {

            view.window?.rootViewController = TabController()
            view.window?.makeKeyAndVisible()
            
        } else {
            
            view.window?.rootViewController = UINavigationController(rootViewController: LogInViewController())
            view.window?.makeKeyAndVisible()
           
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setRootViewController()
    }

   

}
