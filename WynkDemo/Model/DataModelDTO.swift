//
//  DataModelDTO.swift
//  WynkDemo
//
//  Created by Smriti on 15/05/20.
//  Copyright © 2020 Smriti. All rights reserved.
//

import Foundation

struct DataModelDTO: Decodable{
    
    var id: Int?
    var pageURL : String?
    var type : String
    var tags : String?
    var previewURL : String?
    var webformatURL : String?
    var webformatWidth : Int?
    var webformatHeight : Int?
    var largeImageURL : String
    var imageWidth : Int?
    var imageHeight : Int?
    var user_id : Int?
    var user : String?
    var userImageURL : String?
    
    init(url: String, type:String) {
        self.largeImageURL = url
        self.type = type
    }
    enum CodingKeys: String, CodingKey {
           case largeImageURL, type  = "type"
       }
    
}

struct ResultantDataModel: Decodable{
    var total: Int?
    var totalHits : Int?
    var hits: [DataModelDTO]
}
