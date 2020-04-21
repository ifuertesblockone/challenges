import Foundation
import XCTest

final class ChallengeTwo {
    struct Constants {
        static let min = 1
        static let max = 20
    }
    
    func fizzBuzz() -> String {
        let numbers: [Int] = Array(Constants.min...Constants.max)
        
        var outputValues: [String] = []
        
        outputValues = numbers.reduce(into: outputValues) { (result, number) in
            var newNumberValue = ""
            if isMultipleOfThree(number) || isMultipleOfFive(number) {
                if isMultipleOfThree(number) {
                    newNumberValue = "Fizz"
                }
                if isMultipleOfFive(number) {
                    newNumberValue = newNumberValue + "Buzz"
                }
            } else {
                newNumberValue = String(format: "%d", number)
            }
            
            result.append(newNumberValue)
        }
        
        return outputValues.joined(separator: "\n")
    }
}

private extension ChallengeTwo {
    func isMultipleOfThree(_ num: Int) -> Bool {
        return num % 3 == 0
    }
    
    func isMultipleOfFive(_ num: Int) -> Bool {
        return num % 5 == 0
    }
}

class ChallengeTwoTests: XCTestCase {
    typealias `Self` = ChallengeTwoTests
    
    static let expectedOutput = """
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
    
    var sut: ChallengeTwo!

    override func setUp() {
        super.setUp()
        sut = ChallengeTwo()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_FizzBuzz_TheOutputHasTheCorrectSequence() {
        // When
        let output = sut.fizzBuzz()
        
        // Then
        XCTAssertEqual(output,
                       Self.expectedOutput,
                       "The output must be equal to the expectedOutput, because it is the correct sequence for this range of numbers")
    }
}

ChallengeTwoTests.defaultTestSuite.run()
