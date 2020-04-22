import Foundation
import XCTest

/*
 ### FizzBuzz

 Write a short program that prints each number from 1 to 20 on a new line and that
 follow these rules :
  - For each multiple of 3, print "Fizz" instead of the number.
  - For each multiple of 5, print "Buzz" instead of the number.
  - For number that are multiple of both 3 1nd 5, print "FizzBuzz" instead of the number
 */

func fizzBuzz(until value: Int) -> String {
    var fizzBuzzOutput = [String]()
    if value < 1 { return "Insert only positive integers" }
    (1...value).forEach {
        switch ($0.isMultiple(of: 3), $0.isMultiple(of: 5)) {
        case (true, true):
            fizzBuzzOutput.append("FizzBuzz")
        case (true, false):
            fizzBuzzOutput.append("Fizz")
        case (false, true):
            fizzBuzzOutput.append("Buzz")
        default:
            fizzBuzzOutput.append("\($0)")
        }
    }
    return fizzBuzzOutput.joined(separator: "\n")
}

fizzBuzz(until: 1)

final class FizzBuzzTests: XCTestCase {
    struct Constants {
        static let fizzBuzzCorrect1Input = 1
        static let fizzBuzzCorrect1 = FizzBuzzMocks.fizzBuzzCorrectFor1
        static let fizzBuzzCorrect10Input = 10
        static let fizzBuzzCorrect10 = FizzBuzzMocks.fizzBuzzCorrectFor10
        static let fizzBuzzCorrect20Input = 20
        static let fizzBuzzCorrect20 = FizzBuzzMocks.fizzBuzzCorrectFor20
        static let fizzBuzzCorrectNegativeInput = -5
        static let negativeOrZeroMessage = "Insert only positive integers"
    }
    
    func test_fizzBuzz_correct_1() {
        let fizzBuzzOutput = fizzBuzz(until: Constants.fizzBuzzCorrect1Input)
        XCTAssertEqual(fizzBuzzOutput, Constants.fizzBuzzCorrect1, "FizzBuzz sequence should be as Mocked value fizzBuzzCorrectFor1")
    }
    
    func test_fizzBuzz_correct_10() {
        let fizzBuzzOutput = fizzBuzz(until: Constants.fizzBuzzCorrect10Input)
        XCTAssertEqual(fizzBuzzOutput, Constants.fizzBuzzCorrect10, "FizzBuzz sequence should be as Mocked value fizzBuzzCorrectFor10")
    }
    
    func test_fizzBuzz_correct_20() {
        let fizzBuzzOutput = fizzBuzz(until: Constants.fizzBuzzCorrect20Input)
        XCTAssertEqual(fizzBuzzOutput, Constants.fizzBuzzCorrect20, "FizzBuzz sequence should be as Mocked value fizzBuzzCorrectFor20")
    }
    
    func test_fizzBuzz_negative() {
        let fizzBuzzOutput = fizzBuzz(until: Constants.fizzBuzzCorrectNegativeInput)
        XCTAssertEqual(fizzBuzzOutput, Constants.negativeOrZeroMessage, "Error message should be returned by the fizzBuzz function")
    }
}


final class FizzBuzzMocks {
    static let fizzBuzzCorrectFor20 = """
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
    static let fizzBuzzCorrectFor10 = """
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
"""
    static let fizzBuzzCorrectFor1 = "1"
}


FizzBuzzTests.defaultTestSuite.run()
