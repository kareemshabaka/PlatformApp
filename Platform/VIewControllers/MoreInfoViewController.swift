//
//  MoreInfoViewController.swift
//  Platform
//
//  Created by Kareem Shabaka on 4/29/20.
//  Copyright © 2020 Kareem Shabaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class List {
    
    var name: String
    var rating: String
    
    init(name: String, rating: String) {
        
        self.name = name
        self.rating = rating
        
    }
}


class MoreInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
   
    var finalSelection: String = ""
    private var providersList = [List]()
    let tableView = UITableView()
    let noListings = UILabel()
    var refreshControl = UIRefreshControl()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        providersList = [List]()
        downloadData()
        
        self.refreshControl.endRefreshing()
    }
    
    
    
    final func setTableView() {
    
        if providersList.count == 0 {
            
            view.backgroundColor = .white
            view.addSubview(noListings)
            noListings.text = "No listings found"
            noListings.translatesAutoresizingMaskIntoConstraints = false
            noListings.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
            noListings.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
                   
        } else {
            
            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(MoreInfoTableViewCell.self, forCellReuseIdentifier: "Cell")
            tableView.separatorColor = .clear
        
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providersList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MoreInfoTableViewCell
        
        cell.moreInfoLabel.text = providersList[indexPath.row].name
        cell.ratingImage.image = UIImage(named: providersList[indexPath.row].rating)
        
        return cell

    }
    
       func downloadData() {

        finalSelection = UserDefaults.standard.string(forKey: "MoreInfo")!
        
        db.collection("\(finalSelection.lowercased())_providers").getDocuments() { (querySnapshot, err) in
             if let err = err {
                 print("Error getting documents: \(err)")
             } else {
                
                 for document in querySnapshot!.documents {
                
                    self.providersList.append(List(name:"\(document.documentID)", rating: "\(document.data())"))
                
                 }
                self.setTableView()
                self.tableView.reloadData()
             }
         }
     }
    
     var selection: String = ""
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           self.selection = providersList[indexPath.row].name
           navigationController?.pushViewController(DetailViewController(), animated: true)
           UserDefaults.standard.set("\(selection)", forKey: "Detail")
           
       }
    
    

}

