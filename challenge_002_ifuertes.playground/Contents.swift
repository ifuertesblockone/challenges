/*:
 ***
 ### FizzBuzz
 
 Write a short program that prints each number from 1 to 50 on a new line.
 
 For each multiple of 3, print "Fizz" instead of the number.
 For each multiple of 5, print "Buzz" instead of the number.
 For numbers which are multiples of both 3 and 5, print "FizzBuzz" instead of the number.
 ***
 */

import Foundation
import XCTest

func fuzzBuzz(_ array: [Int]) -> String {
    var fuzzbuzz = [String]()
    
    for number in array {
        let test = (number % 3 == 0, number % 5 == 0)
        switch test {
        case (true, true):
            fuzzbuzz.append("FizzBuzz")
        case (true, false):
            fuzzbuzz.append("Fizz")
        case (false, true):
            fuzzbuzz.append("Buzz")
        default:
            fuzzbuzz.append("\(number)")
        }
    }
    
    return fuzzbuzz.joined(separator: "\n")
}

class FuzzBuzzTest: XCTestCase {
    
    override class func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFuzzBuzz() {
        // GIVEN
        let testArray = Array(1...50)
        let expectedOutput = """
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
Fizz
22
23
Fizz
Buzz
26
Fizz
28
29
FizzBuzz
31
32
Fizz
34
Buzz
Fizz
37
38
Fizz
Buzz
41
Fizz
43
44
FizzBuzz
46
47
Fizz
49
Buzz
"""
        
        // WHEN
        let result = fuzzBuzz(testArray)
        
        // THEN
        XCTAssertTrue(result == expectedOutput, "\(result) is no the same as \(expectedOutput)")
    }
}

FuzzBuzzTest.defaultTestSuite.run()

//: ***
//: [Previous](@previous) || [Next](@next)
