import Foundation
import XCTest

final class ChallengeOne {
    func simpleAdding(_ num: Int) -> Int {
        if num <= 0 {
            return 0
        }
        else {
            return num + simpleAdding(num - 1)
        }
    }
}

class ChallengeOneTests: XCTestCase {
    var sut: ChallengeOne!

    override func setUp() {
        super.setUp()
        sut = ChallengeOne()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_NumIsLessThanZero_SimpleAdding_TheFunctionReturnsZero() {
        // Given
        let num = -1

        // When
        let output = sut.simpleAdding(num)

        // Then
        XCTAssertEqual(output, 0, "The output must be equal to zero because the number given is not a valid number into the range of the numbers")
    }

    func test_NumIsEqualToZero_SimpleAdding_TheFunctionReturnsZero() {
        // Given
        let num = 0

        // When
        let output = sut.simpleAdding(num)

        // Then
        XCTAssertEqual(output, 0, "The output must be equal to zero because zero is not a valid number into the range of the numbers")
    }

    func test_NumIsFour_SimpleAdding_TheFunctionReturnsTen() {
        // Given
        let num = 4
        
        // When
        let output = sut.simpleAdding(num)

        // Then
        XCTAssertEqual(output, 10, "The output must be equal to 10 because it is the correct result when the input is 4")
    }

    func test_NumIsEight_SimpleAdding_TheFunctionReturnsThirtySix() {
        // Given
        let num = 8
        
        // When
        let output = sut.simpleAdding(num)

        // Then
        XCTAssertEqual(output, 36, "The output must be equal to 36 because it is the correct result when the input is 8")
    }
}

ChallengeOneTests.defaultTestSuite.run()
