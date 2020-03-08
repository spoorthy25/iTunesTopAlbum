//
//  NetworkManagerTests.swift
//  AlbumGerneTests
//
//  Created by Spoorthy Kancharla on 2/3/20.
//  Copyright © 2020 Spoorthy Kancharla. All rights reserved.
//

import XCTest
@testable import AlbumGerne

class NetworkManagerTests: XCTestCase {

    var session = URLSession()
    override func setUp() {
        super.setUp()
        session = URLSession(configuration: .default)
    }

    override func tearDown() {
        
        super.tearDown()
    }

    func testFetchAlbumsGetsHTTPStatusCode200() {
      
        let url =  URL(string: host + endpoint)
      
      let promise = expectation(description: "Completion handler invoked")
      var statusCode: Int?
      var responseError: Error?
        if let urlValue = url {
          let dataTask = session.dataTask(with: urlValue ) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
          }
            dataTask.resume()
        }
      
      wait(for: [promise], timeout: 5)

      
      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
