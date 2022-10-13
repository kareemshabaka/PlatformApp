//
//  AppManager.swift
//  Platform
//
//  Created by Kareem Shabaka on 4/27/20.
//  Copyright © 2020 Kareem Shabaka. All rights reserved.
//

import UIKit
import Firebase

//class AppManager {
//    
//    static let shared = AppManager()
//    
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    var appContainer: ViewManager!
//    
//    private init() { }
//    
//    func showApp() {
//        var viewController: UIViewController
//        
//        if Auth.auth().currentUser == nil {
//            viewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
//        } else {
//            viewController = storyboard.instantiateViewController(withIdentifier: "HomeVC")
//            
//            
//        }
//        
//        appContainer.present(viewController, animated: true, completion: nil)
//        
//    }
//    
//    func logout() {
//        try! Auth.auth().signOut()
//        appContainer.presentedViewController?.dismiss(animated: true, completion: nil)
//        
//    }
//}


