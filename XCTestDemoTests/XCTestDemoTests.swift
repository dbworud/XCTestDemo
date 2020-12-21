//
//  XCTestDemoTests.swift
//  XCTestDemoTests
//
//  Created by jaekyung you on 2020/12/20.
//

import XCTest
@testable import XCTestDemo

class XCTestDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_should_download_data_successfully() {
        var downloadedData : Data?
        
        let exp = expectation(description: "Download apple.com data")
        let url = URL(string: "https://apple.com")!
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            downloadedData = data
            XCTAssertNotNil(data, "No data was downloaded")
            exp.fulfill()
            
        }.resume()
        
        XCTAssertNil(downloadedData)
        wait(for: [exp], timeout: 10.0)
    }

}
