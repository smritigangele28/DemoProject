//
//  WynkDemoUITests.swift
//  WynkDemoUITests
//
//  Created by Smriti on 14/05/20.
//  Copyright © 2020 Smriti. All rights reserved.
//

import XCTest

class WynkDemoUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEditingSearchField(){
 
        app.alerts["Sorry!"].scrollViews.otherElements.buttons["Ok"].tap()
        app.textFields["Search "].tap()
        app.tables.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.swipeUp()
                
    }
    
    // These kind of other test cases we can write here for UI testing
}
