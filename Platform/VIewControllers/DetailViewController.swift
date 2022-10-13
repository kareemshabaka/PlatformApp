//
//  DetailViewController.swift
//  Platform
//
//  Created by Kareem Shabaka on 5/10/20.
//  Copyright © 2020 Kareem Shabaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class DetailViewController: UIViewController {

    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadInfo()
        Utilities.styleNavBar(navigationController!)
    }
     
    var finalSeleciton = UserDefaults.standard.string(forKey: "MoreInfo")
    var detailSelection = UserDefaults.standard.string(forKey: "Detail")!
    
    func downloadInfo() {
        
        let docRef = db.collection("\(finalSeleciton!.lowercased())_providers").document(detailSelection).collection("info").document("moreinfo")
        
        docRef.getDocument { (snapshot, error) in
            
            if let err = error {
                print("\(err)")
            } else {
            
                let data = snapshot!.data()
                
                let mainText = data?["maintext"] as? String ?? "An"
                print("\(mainText)")
            }
            
        }

    }


}
