//
//  ValidationServiceTest.swift
//  XCTestDemoTests
//
//  Created by jaekyung you on 2020/12/20.
//

import XCTest

@testable import XCTestDemo

class ValidationServiceTest: XCTestCase {
    
    var validation: ValidationService!
    
    // setUp > Test메소드1 > tearDown > setUp > Test메소드2 > tearDown
    
    // customize an initial state before <<a test>> case begins -> override class func
    // reset state before calling <<each test method>> in a test case -> override func
    
    // add instance for test like viewDidLoad()
    override func setUp() { // for each test
        super.setUp() // when override another viewcontroller or class, keep that functionality
        validation = ValidationService()
    }
    
    // clean up each test case
    override func tearDown() {
        super.tearDown()
        validation = nil
    }

    // test case에서는 snake case로 쓰는게 관행
    func test_is_valid_username() throws {
        // if it doesnt throw anything, it means test pass
        // 즉, throw구문에 빠지지 않고 조건에 충족한다면
        XCTAssertNoThrow(try validation.validateUsername("youjk96"))
    }

    func test_is_usernmae_nil() throws {
        let expectedError = ValidationError.invalidValue
        var error : ValidationError?
        
        // nil이면 ThrowsError = true = test pass
        XCTAssertThrowsError(try validation.validateUsername(nil)) { thrownError in
            // check if return correct error message
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_is_username_short() throws {
        let expectedError = ValidationError.usernameTooShort
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateUsername("you")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_is_username_long() throws {
        let expectedError = ValidationError.usernameTooLong
        var error: ValidationError?
        let username = "very long user name1"
        
        XCTAssertTrue(username.count == 20)
        
        XCTAssertThrowsError(try validation.validateUsername(username)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
}
