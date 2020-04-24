import Foundation
import XCTest

final class ChallengeThree {
    struct Constants {
        static let alphabetSet = Set("abcdefghijklmnopqrstuvwxyz")
    }
    
    func largestWord(from text: String) -> String {
        let words = text.components(separatedBy: " ")
            .map { cleanWord(with: $0) }
            .sorted(by: { $0.count > $1.count })
        
        return words.first ?? ""
    }
}

private extension ChallengeThree {
    func cleanWord(with text: String) -> String {
        let extraCharacters = Set(text).subtracting(Constants.alphabetSet)
        
        return text.filter { !extraCharacters.contains($0) }
    }
}

final class ChallengeThreeTests: XCTestCase {
    var sut: ChallengeThree!

    override func setUp() {
        super.setUp()
        sut = ChallengeThree()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_ThereAreValidWords_LargestWord_TheFunctionReturnsTheLargestWord() {
        // Given
        let expectedOutput = "aaaaa"
        let input = "aaaaa bbbbb"

        // When
        let output = sut.largestWord(from: input)

        // Then
        XCTAssertEqual(output, expectedOutput, "The output must get the largest word into the input without punctuation")
    }
    
    func test_ThereIsNoValidWord_LargestWord_TheFunctionReturnsAnEmptyString() {
        // Given
        let expectedOutput = ""
        let input = " "

        // When
        let output = sut.largestWord(from: input)

        // Then
        XCTAssertEqual(output, expectedOutput, "The output must get and empty string because there is no words")
    }
}

ChallengeThreeTests.defaultTestSuite.run()
