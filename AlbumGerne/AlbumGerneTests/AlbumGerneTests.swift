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
    
    var albums = [Album]()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        do {
            if let file = Bundle.main.url(forResource: "Result", withExtension: "json") {
                let json = try Data.init(contentsOf: file)
                let response = try JSONDecoder().decode(AlbumFeed.self, from: json)
                let albumFeed = response.feed
                albums = albumFeed.results
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParseResponse() {
        
         XCTAssertTrue(albums.count == 1)
    }

    func testAlbumNameDate() {
        for album in albums{
            XCTAssertTrue(album.name == "Chromatica")
        }
        
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
