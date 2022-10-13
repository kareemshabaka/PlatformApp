//
//  ShortlistViewController.swift
//  Platform
//
//  Created by Kareem Shabaka on 5/7/20.
//  Copyright © 2020 Kareem Shabaka. All rights reserved.
//

import UIKit

class Shortlist {
    
    var category: String
    var companyName: String
    var dateAdded: String
    
    init(category: String, companyName: String, dateAdded: String) {
        
        self.category = category
        self.companyName = companyName
        self.dateAdded = dateAdded
        
    }

}

class ShortlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let shortlistArray = [Shortlist]()
    let noShortlist = UILabel()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popShortlistView()
        view.backgroundColor = .white
        Utilities.styleNavBar(navigationController!)
    }
    
    func popShortlistView() {
        
        if shortlistArray.count == 0 {
            noShortlistView()
        } else {
            popTableView()
        }
        
    }
   
    func noShortlistView() {
        
        view.addSubview(noShortlist)
        noShortlist.translatesAutoresizingMaskIntoConstraints = false
        noShortlist.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        noShortlist.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noShortlist.text = "You have not shortlisted any services"
        
    }
    
    func popTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorColor = .clear
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shortlistArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.nameLabel.text = shortlistArray[indexPath.row].companyName
        
        return cell
    }
    
}
