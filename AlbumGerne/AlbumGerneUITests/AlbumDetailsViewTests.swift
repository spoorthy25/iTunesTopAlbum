//
//  AlbumDetailsViewTests.swift
//  AlbumGerneUITests
//
//  Created by Spoorthy Kancharla on 2/3/20.
//  Copyright © 2020 Spoorthy Kancharla. All rights reserved.
//

import XCTest

class AlbumDetailsViewTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlbumDetailedScreen(){
        
        let app = XCUIApplication()
        app.launch()
    
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        let element = element2.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        element.tap()
        element.tap()
        
        let lilBabyStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Lil Baby"]/*[[".cells.staticTexts[\"Lil Baby\"]",".staticTexts[\"Lil Baby\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lilBabyStaticText.tap()
        app.navigationBars["AlbumGerne.AlbumDetailsView"].buttons["Back"].tap()
        lilBabyStaticText.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Open in iTunes"]/*[[".buttons[\"Open in iTunes\"].staticTexts[\"Open in iTunes\"]",".staticTexts[\"Open in iTunes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
                          
        
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
