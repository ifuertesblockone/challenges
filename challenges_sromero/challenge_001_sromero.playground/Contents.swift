import Foundation
import XCTest

/*
 ### Simple Adding
 Have the function simpleAdding(num) add up all the numbers from 1 to num.
 For example: if the input is 4 then your program should return 10 because 1 + 2 + 3 + 4 = 10.
 For the test cases, the parameter num will be any number from 1 to 1000.
 */

func simpleAdding(to num: Int) -> Int {
    if num <= 0 {
        return 0
    }
    
    var total = 0
    (1...num).forEach {
        total += $0
    }
    
    return total
}

final class SimpleAddingTests: XCTestCase {
    
    struct Constants {
        static let successfulCaseParam = 4
        static let successfulCaseResult = 11
        static let negativeCaseParam = -5
        static let negativeCaseResult = 0
        static let zeroCaseParam = 0
        static let zeroCaseResult = 0
    }
    
    func test_simpleAdding_correct() {
        let result = simpleAdding(to: Constants.successfulCaseParam)
        XCTAssertEqual(result, Constants.successfulCaseResult, "Result of simpleAdding from 1 to 4 is not correct, should be 10")
    }
    
    func test_simpleAdding_negative() {
        let result = simpleAdding(to: Constants.negativeCaseParam)
        XCTAssertEqual(result, Constants.negativeCaseResult, "Result of simpleAdding for negative should be 0")
    }
    
    func test_simpleAdding_zero() {
        let result = simpleAdding(to: Constants.zeroCaseParam)
        XCTAssertEqual(result, Constants.zeroCaseResult, "Result of simpleAdding for 0 should be 0")
    }
    
}

SimpleAddingTests.defaultTestSuite.run()
