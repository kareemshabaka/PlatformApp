//
//  ViewController.swift
//  Platform
//
//  Created by Kareem Shabaka on 4/21/20.
//  Copyright © 2020 Kareem Shabaka. All rights reserved.
//

import UIKit
import Firebase

private class Categories {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
        
    }
    
}

class MainSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    fileprivate var categoryArray = [Categories]()
    fileprivate var filteredArray = [Categories]()
    
    let tableView = UITableView()
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCategories()
        configureUI()
        setTableView()
        view.backgroundColor = .red
    
    }

    var mainSearch: UIViewController?
    var account: UIViewController?

    final func setTableView() {
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
    
    @objc func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    final func configureUI () {
        
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        showSearchButton(shouldShow: true)
        
        Utilities.styleNavBar(navigationController!)
        
    }
    
    func showSearchButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
            
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
        
    }
    
    final func setUpCategories() {
        
        categoryArray.append(Categories(name: "Architecture", image: "Architecture"))
        //categoryArray.append(Categories(name: "Dessert", image: "Dessert"))
        categoryArray.append(Categories(name: "Educational Services", image: "Educational Services"))
        categoryArray.append(Categories(name: "Fashion", image: "Fashion"))
        categoryArray.append(Categories(name: "Financial Services", image: "Financial Services"))
        categoryArray.append(Categories(name: "House Maintenance", image: "House Maintenance"))
        //categoryArray.append(Categories(name: "Interior Designers", image: "Interior Designer"))
        categoryArray.append(Categories(name: "Marketing", image: "Marketing"))
        //categoryArray.append(Categories(name: "Medical Innovation", image: "Medical Innovation"))
        categoryArray.append(Categories(name: "Photography", image: "Photography"))
        //categoryArray.append(Categories(name: "Real Estate", image: "Real Estate"))
        //categoryArray.append(Categories(name: "Software Development", image: "Software Development"))
        categoryArray.append(Categories(name: "Wedding Planner", image: "Wedding Planner"))
        
        filteredArray = categoryArray
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.nameLabel.text = filteredArray[indexPath.row].name
        cell.profileImageView.image = UIImage(named: filteredArray[indexPath.row].image)
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { filteredArray = categoryArray
            tableView.reloadData()
            return }
        
        filteredArray = categoryArray.filter({ item -> Bool in
            item.name.lowercased().hasPrefix(searchText.lowercased())})
        tableView.reloadData()
        
    }
    
    var selection: String = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selection = filteredArray[indexPath.row].name
        navigationController?.pushViewController(MoreInfoViewController(), animated: true)
        UserDefaults.standard.set("\(selection)", forKey: "MoreInfo")
        
    }
    
   
}

extension MainSearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
        filteredArray = categoryArray
        tableView.reloadData()
        searchBar.text = ""
    }
    
}
