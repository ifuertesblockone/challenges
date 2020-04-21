import UIKit
import XCTest

//### Simple Adding
//Have the function simpleAdding(num) add up all the numbers from 1 to num.
//For example: if the input is 4 then your program should return 10 because 1 + 2 + 3 + 4 = 10.
//For the test cases, the parameter num will be any number from 1 to 1000.


func simpleAdding(num: Int) -> Int {
    (1...num).reduce(into: 0) { $0 += $1 }
}

final class UserManagerTests: XCTestCase {
    
    func testAdding() {
        let givenNumber = 3
        
        let receivedResult = simpleAdding(num: givenNumber)
        
        XCTAssertEqual(receivedResult, 6, "The received result is not valid")
    }
}

UserManagerTests.defaultTestSuite.run()
