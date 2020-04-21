//
//  Challenge_01_hbautistablockone.swift
//  Challenge_01
//
//  Created by Henry Bautista on 21/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import Foundation
import XCTest


// MARK: main class
class Challenge_01{
    
    // MARK: function simpleAdding
    // @params: Optional Int
    func simpleAdding(number: Int?) -> Int {
        guard let `number` = number else {
            return 0
        }
        if number > 0 {
           return  number  + simpleAdding(number: number - 1)
        }
        else {
            return number
        }
    }
}


// MARK: Test development class Clhallenge Test
class ChallengeTests: XCTestCase {
    
    var challenge: Challenge_01!
    
    // MARK: Default scope
    override func setUp() {
        super.setUp()
        challenge = Challenge_01()
    }
    
    override func tearDown() {
        challenge = nil
        super.tearDown()
    }

    // MARK: test nil value
    func testNil() {
        XCTAssertEqual(challenge.simpleAdding(number: nil), 0)
    }
    
    // MARK: test negative values
    func testNegativeNotAllowed() {
        let x = -20
        XCTAssertEqual(challenge.simpleAdding(number: x), -20)
    }
    
    // MARK: test Zero Value
    func testZero() {
        let x = 0
        XCTAssertEqual(challenge.simpleAdding(number: x), 0)
    }
    
    // MARK: test Positive Values
    func testDefault() {
        let x = 4
        XCTAssertEqual(challenge.simpleAdding(number: x), 10)
    }
    
    // MARK: Test Recalling
    func testVerifyDefault() {
        let x = 4
        let y = challenge.simpleAdding(number: x)
        XCTAssertEqual(challenge.simpleAdding(number: y), 55)
    }
}

// MARK: Default Test Executions
ChallengeTests.defaultTestSuite.run()



