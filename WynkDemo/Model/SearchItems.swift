//
//  SearchItems.swift
//  WynkDemo
//
//  Created by Smriti on 16/05/20.
//  Copyright © 2020 Smriti. All rights reserved.
//

import Foundation

struct SearchItem: Equatable{
    
   var attributedSearchName: NSMutableAttributedString?
   var allAttributedName : NSMutableAttributedString?
   var nameType: String
    
    public init(searchSttring: String) {
        self.nameType = searchSttring
    }
    
    public mutating func getFormatedText() -> NSMutableAttributedString{
        allAttributedName = NSMutableAttributedString()
        allAttributedName!.append(attributedSearchName!)
        
        return allAttributedName!
    }
    
    public func getStringText() -> String{
        return "\(nameType)"
    }

}
