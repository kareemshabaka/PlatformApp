//
//  TabController.swift
//  Platform
//
//  Created by Kareem Shabaka on 5/5/20.
//  Copyright © 2020 Kareem Shabaka. All rights reserved.
//

import UIKit

class TabController: UITabBarController, UITabBarControllerDelegate {

    let kBarHeight = CGFloat(60)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let mainSeach = UINavigationController(rootViewController: MainSearchViewController())
        mainSeach.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let shortlist = UINavigationController(rootViewController: ShortlistViewController())
        shortlist.tabBarItem = UITabBarItem(title: "Shortlist", image: UIImage(named: "bookmark-button"), tag: 1)
        
        
        let account = UINavigationController(rootViewController: AccountViewController())
        account.tabBarItem = UITabBarItem(title: "Account", image: UIImage(named: "framed-portrait"), tag: 2)
        
        let tabBarList = [mainSeach, shortlist, account]
        self.viewControllers = tabBarList
        
        tabBar.barTintColor = .white
        tabBar.tintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        
    }
    
}



