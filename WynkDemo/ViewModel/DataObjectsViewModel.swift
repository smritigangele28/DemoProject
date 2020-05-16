//
//  DataObjectsViewModel.swift
//  WynkDemo
//
//  Created by Smriti on 16/05/20.
//  Copyright © 2020 Smriti. All rights reserved.
//

import Foundation

struct DataObjectsViewModel{
    
    var imageURL : String
    
    init(data: DataModelDTO) {
        self.imageURL = data.largeImageURL
    }
    
}
