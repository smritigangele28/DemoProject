//
//  SuggestedListTableViewCell.swift
//  WynkDemo
//
//  Created by Smriti on 14/05/20.
//  Copyright © 2020 Smriti. All rights reserved.
//


import UIKit

class SuggestedListTableViewCell: UITableViewCell {
    
    var lightColor = UIColor.lightGray
    var cellFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(with title: NSMutableAttributedString) {
        self.selectionStyle = .none
        self.textLabel?.font = cellFont
        self.textLabel?.textColor = self.lightColor
        self.backgroundColor = UIColor.clear
        self.textLabel?.attributedText = title
    }
}
