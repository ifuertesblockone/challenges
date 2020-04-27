//
//  Challenge_02_hbautistablockone.swift
//  Challenge_02
//
//  Created by Henry Bautista on 21/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import Foundation
import XCTest


// MARK: main class
class Challenge_02{
    
    // MARK: function fizzbuzz
    // @params: Optional Int
    func fizzbuzz(number: Int?) -> String {
        guard let `number` = number else {
            return ""
        }
        switch (number % 3 == 0, number % 5 == 0) {
        case (true, false):
            return "Fizz"
        case (false, true):
            return "Buzz"
        case (true, true):
            return "FizzBuzz"
        case (false, false):
            return String(number)
        }
    }

    func concatenate(x: Int?) -> String{
        var result = ""
        guard x != nil else {
            return ""
        }
        for x in 1 ... 20 {
            result += fizzbuzz(number: x)
            if x != 20 { result += "\n"}
        }
        return result
    }
}


// MARK: Test development class Clhallenge Test
class ChallengeTests: XCTestCase {
    
    var challenge: Challenge_02!
    
    // MARK: Default scope
    override func setUp() {
        super.setUp()
        challenge = Challenge_02()
    }
    
    override func tearDown() {
        challenge = nil
        super.tearDown()
    }

    // MARK: test nil value
    func testNil() {
        XCTAssertEqual(challenge.fizzbuzz(number: nil), "")
    }
    
    // MARK: test Output Value
    func testOutput() {
        let out = """
        1
        2
        Fizz
        4
        Buzz
        Fizz
        7
        8
        Fizz
        Buzz
        11
        Fizz
        13
        14
        FizzBuzz
        16
        17
        Fizz
        19
        Buzz
        """
        XCTAssertEqual(challenge.concatenate(x: 20),out)
    }
}

// MARK: Default Test Executions
ChallengeTests.defaultTestSuite.run()
