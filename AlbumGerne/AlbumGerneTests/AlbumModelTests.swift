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

    var album:[Album]?
    var albums:AlbumResult?
    var albumFeed: AlbumFeed?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        do {
            if let file = Bundle.main.url(forResource: "Result", withExtension: "json") {
                let json = try Data.init(contentsOf: file)
                let response = try JSONDecoder().decode(AlbumFeed.self, from: json)
                albumFeed = response
                albums = albumFeed?.feed
                album = albums?.results
                
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

    func testAlbumModel() {
        
        XCTAssertTrue(albumFeed?.feed.results.count == 1)
        
        XCTAssertTrue(albums?.results.count == 1)
        
        XCTAssertTrue(album?.count == 1)
        
        
        
    }

    func testAlbumModelData() {
        if let albumData = album{
            for album in albumData{
                XCTAssertTrue(album.name == "Chromatica")
                XCTAssertTrue(album.artistName == "Lady Gaga")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
