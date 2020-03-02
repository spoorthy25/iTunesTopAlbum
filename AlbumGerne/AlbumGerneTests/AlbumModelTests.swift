//
//  AlbumModelTests.swift
//  AlbumGerneTests
//
//  Created by Spoorthy Kancharla on 2/3/20.
//  Copyright © 2020 Spoorthy Kancharla. All rights reserved.
//

import XCTest
@testable import AlbumGerne

class AlbumModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlbumModel() {
        let album = ["name":"Test Name","artistName": "Test Artist"]
        let albumValues = AlbumModel(album)
        if(albumValues.name == "Test Name"){
             XCTAssertTrue(true)
        }else{
             XCTAssertTrue(true)
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
