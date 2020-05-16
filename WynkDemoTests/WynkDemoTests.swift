//
//  WynkDemo xcodeTests.swift
//  WynkDemoTests
//
//  Created by Smriti on 14/05/20.
//  Copyright © 2020 Smriti. All rights reserved.
//

import XCTest
import CoreData
@testable import WynkDemo

class WynkDemoTests: XCTestCase {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var coreDataManager = AutoSuggestTextField()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       coreDataManager = AutoSuggestTextField.sharedManager
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
 func testDataModelImages(){
     let data = DataModelDTO(url: "image.jpg", type: "photo")
     let dataViewModel = DataObjectsViewModel(data: data)
     XCTAssertEqual(data.largeImageURL, dataViewModel.imageURL)
 }

    func test_create_person() {
        
        //test data
        let text1 = "Alok"
         
        let text2 = "Naitvik"
 
        let text3 = "Deepti"
     
        let result1 = Result(context: context)
        result1.nameType = text1
        let savedData1: () = coreDataManager.saveItems(text: result1.nameType!)
        XCTAssertNotNil( savedData1 )
        
        let result2 = Result(context: context)
        result2.nameType = text2
        let savedData2: () = coreDataManager.saveItems(text: result1.nameType!)
        XCTAssertNotNil( savedData2 )
          
        let result3 = Result(context: context)
        result3.nameType = text3
        let savedData3: () = coreDataManager.saveItems(text: result1.nameType!)
        XCTAssertNotNil( savedData3 )

        coreDataManager.dataList.append(result1)
        coreDataManager.dataList.append(result2)
        coreDataManager.dataList.append(result3)

        print(coreDataManager.dataList.count)
      }
    
    /*This test case fetches all person records*/
      func test_fetch_all_person() {
        
        //get personRecord already saved
        let result = coreDataManager.loadItems(withRequest: Result.fetchRequest())
        //Assert return numbers of todo items
        //Asserts that two optional values are equal.
        XCTAssertEqual(result?.count, coreDataManager.dataList.count)
      }
    
}
