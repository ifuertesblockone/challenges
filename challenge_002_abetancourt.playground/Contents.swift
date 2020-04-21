import UIKit
import XCTest

//Write a short program that prints each number from 1 to 20 on a new line and that
//follow these rules :
// - For each multiple of 3, print "Fizz" instead of the number.
// - For each multiple of 5, print "Buzz" instead of the number.
// - For number that are multiple of both 3 1nd 5, print "FizzBuzz" instead of the number


func findMultipliers(endNumber: Int) -> [String] {
    var result: [String] = []
    
    (1...endNumber).forEach {
        switch ($0.isMultiple(of: 3), $0.isMultiple(of: 5)) {
        case (true, false): result.append("Fizz")
        case (false, true): result.append("Buzz")
        case (true, true): result.append("FizzBuzz")
        case (false, false): result.append("\($0)")
        }
    }
    return result
}

findMultipliers(endNumber: 20)

final class UserManagerTests: XCTestCase {

    func testAdding() {
        let givenNumber = 20

        let receivedResult = findMultipliers(endNumber: givenNumber)
        
        let expectedResult = ["1", "2", "Fizz", "4", "Buzz", "Fizz",
                              "7", "8",  "Fizz",  "Buzz",  "11",
                              "Fizz", "13",  "14",  "FizzBuzz",
                              "16", "17", "Fizz", "19", "Buzz"]
        
        XCTAssertEqual(receivedResult, expectedResult, "The resived result is not vaild")
    }
}


UserManagerTests.defaultTestSuite.run()
