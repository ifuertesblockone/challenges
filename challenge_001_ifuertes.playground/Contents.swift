/*:
 ***
 ### Simple Adding
 Have the function SimpleAdding(num) add up all the numbers from 1 to num. For example: if the input is 4 then your program should return 10 because 1 + 2 + 3 + 4 = 10. For the test cases, the parameter num will be any number from 1 to 1000.
 ***
 */

import Foundation
import XCTest

func SimpleAdding(_ input: Int) -> Int {
    return Array(1...input).reduce(0, +)
}

class SimpleAddingTest: XCTestCase {
    
    func testSimpleAdding_given4AsInput_return10() {
        // GIVEN
        let input = 4
        let expected = 10
        
        // WHEN
        let result = SimpleAdding(input)
        
        // THEN
        XCTAssertEqual(expected, result, "Adding numbers from 1 to \(input) should be \(expected)")
    }
    
    func testSimpleAdding_given8AsInput_return36() {
        // GIVEN
        let input = 8
        let expected = 36
        
        // WHEN
        let result = SimpleAdding(input)
        
        // THEN
        XCTAssertEqual(expected, result, "Adding numbers from 1 to \(input) should be \(expected)")
    }
    
}

SimpleAddingTest.defaultTestSuite.run()

//: ***
//: [Previous](@previous) || [Next](@next)
