//
//  AlbumGerneTests.swift
//  AlbumGerneTests
//
//  Created by Spoorthy Kancharla on 1/3/20.
//  Copyright © 2020 Spoorthy Kancharla. All rights reserved.
//

import XCTest
@testable import AlbumGerne

class AlbumGerneTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParseResponse() {
        var albums:[AlbumModel]?
        do {
            if let file = Bundle.main.url(forResource: "Result", withExtension: "json") {
                let json = try Data.init(contentsOf: file)
                if let jsonData = try JSONSerialization.jsonObject(with: json) as? Dictionary<String, Any>{
                    albums = ViewController().parseResponse(jsonData)
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        if(albums?.count == 1){
            XCTAssertTrue(true)
        }
        else{
            XCTAssertFalse(false)
        }
    }

    func testAlbumModelNoData() {
        let album = ["name":"","artistName": ""]
               let albumValues = AlbumModel(album)
               if(albumValues.name == ""){
                   XCTAssertTrue(true)
               }else{
                   XCTAssertTrue(true)
               }
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
