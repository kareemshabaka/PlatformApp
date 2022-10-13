//
//  AccountViewController.swift
//  Platform
//
//  Created by Kareem Shabaka on 4/27/20.
//  Copyright © 2020 Kareem Shabaka. All rights reserved.
//

import UIKit
import Firebase



class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    let logOutTapped = UIButton()
    
    var tableView: UITableView!
    var userInfoHeader: UserInfoHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        Utilities.styleNavBar(navigationController!)
        view.backgroundColor = .white
       
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "Settings")
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
        tableView.tableHeaderView = userInfoHeader
        tableView.tableFooterView = UIView()
    }
    
    func configureUI() {
        configureTableView()
    
        navigationController?.navigationItem.title = "Settings"
    }
    
    
    func logOut() {
        
      try! Auth.auth().signOut()
    
        
        view.window?.rootViewController = UINavigationController(rootViewController: LogInViewController())
        view.window?.makeKeyAndVisible()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        
        switch section {
        case .Social: return SocialOptions.allCases.count
        case .Communications: return CommunicationOptions.allCases.count
       
        }
      }
      
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        
        return view
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Settings", for: indexPath) as! SettingsCell
        
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
         case .Social:
            let social = SocialOptions(rawValue: indexPath.row)
            cell.textLabel?.text = social?.description
         case .Communications:
            let communications = CommunicationOptions(rawValue: indexPath.row)
            cell.textLabel?.text = communications?.description
        
         }
        
        return cell
      }
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let section = SettingsSection(rawValue: indexPath.section)
               switch section {
               case .Social:
                let social = SocialOptions(rawValue: indexPath.row)
                    switch social {
                    case .editProfile: navigationController?.pushViewController(EditProfileViewController(), animated: true)
                    case .logout: logOut()
                    default: break
                }
               
               default: break
            
        }
    }
    
}
