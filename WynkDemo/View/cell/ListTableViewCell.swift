//
//  ListTableViewCell.swift
//  WynkDemo
//
//  Created by Smriti on 14/05/20.
//  Copyright © 2020 Smriti. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var searchImage: UIImageView!
    
    var dataViewModel: DataObjectsViewModel!{
        didSet{
            let imageString = dataViewModel.imageURL
            searchImage.loadImageUsingCache(withUrl: imageString)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
