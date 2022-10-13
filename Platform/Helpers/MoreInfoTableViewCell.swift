//
//  MoreInfoTableViewCell.swift
//  Platform
//
//  Created by Kareem Shabaka on 4/29/20.
//  Copyright © 2020 Kareem Shabaka. All rights reserved.
//

import UIKit

class MoreInfoTableViewCell: UITableViewCell {
           
        let ratingImage:UIImageView = {
            let img = UIImageView()
            img.contentMode = .scaleAspectFill
            img.translatesAutoresizingMaskIntoConstraints = false
            img.clipsToBounds = true
               return img
           }()
           
        let moreInfoLabel:UILabel = {
           let label = UILabel()
           label.font = UIFont.boldSystemFont(ofSize: 20)
           label.textColor = .black
           label.translatesAutoresizingMaskIntoConstraints = false
               return label
           }()
    
           override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
               super.init(style: style, reuseIdentifier: reuseIdentifier)
               
            contentView.addSubview(ratingImage)
            contentView.addSubview(moreInfoLabel)
           
            ratingImage.centerXAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.centerXAnchor).isActive = true
            ratingImage.widthAnchor.constraint(equalToConstant:190).isActive = true
            ratingImage.heightAnchor.constraint(equalToConstant:30).isActive = true
            ratingImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25).isActive = true
            
        
            moreInfoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            moreInfoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20).isActive = true
            moreInfoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
           
           
           }
           
           required init?(coder aDecoder: NSCoder) {
               
               super.init(coder: aDecoder)
           }
    
}
