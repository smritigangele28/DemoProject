//
//  GalleryCollectionViewCell.swift
//  WynkDemo
//
//  Created by Smriti on 16/05/20.
//  Copyright © 2020 Smriti. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gallaryImage: UIImageView!
    
    var dataViewModel: DataObjectsViewModel!{
          didSet{
              let imageString = dataViewModel.imageURL
              gallaryImage.loadImageUsingCache(withUrl: imageString)
              
          }
      }
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
           gallaryImage.contentMode = .scaleAspectFit
       }
}
