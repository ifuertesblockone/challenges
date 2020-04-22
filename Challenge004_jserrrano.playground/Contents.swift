import Foundation
import XCTest

final class ChallengeFour {
    struct Constants {
        static let vowels = "aeiou"
        static let alphabet = Array("abcdefghijklmnopqrstuvwxyz")
    }
    
    func transform(text: String) -> String {
        let output = text.lowercased().reduce(into: "") { newText, character in
            guard let index = nextIndex(of: character) else {
                return newText += character.toString()
            }
            
            let newCharacter = Constants.alphabet[index]
            
            newText += Constants.vowels.contains(newCharacter) ? newCharacter.uppercased() : newCharacter.toString()
        }
        
        return output
    }
}

private extension ChallengeFour {
    func nextIndex(of character: Character) -> Int? {
        guard let index = Constants.alphabet.firstIndex(of: character)
        else {
            return nil
        }
        
        return index + 1 == Constants.alphabet.count ? 0 : index + 1
    }
}

private extension Character {
    func toString() -> String {
        return String(self)
    }
}

class ChallengeFourTests: XCTestCase {
    var sut: ChallengeFour!

    override func setUp() {
        super.setUp()
        sut = ChallengeFour()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_ThereIsCharactersToReplace_Transform_TheFunctionReturnsTheCorrectSequence() {
        // Given
        let expectedOutput = "bt zpv UI*jOl"
        let input = "as you th*ink"
        
        let secondExpectedOutput = "xIz jt AwbO cpUIfsjOh vt?"
        let secondInput = "why is zvan bothering us?"

        // When
        let output = sut.transform(text: input)
        let secondOutput = sut.transform(text: secondInput)

        // Then
        XCTAssertEqual(output, expectedOutput, "The output must be equal to expectedOutput because it is the correct sequence for this input")
        XCTAssertEqual(secondOutput, secondExpectedOutput, "The output must be equal to expectedOutput because it is the correct sequence for this input")
    }
    
    func test_ThereIsNoCharactersToReplace_Transform_TheFunctionReturnsTheSameInput() {
        // Given
        let input = "1*&ˆ%$& *("

        // When
        let output = sut.transform(text: input)

        // Then
        XCTAssertEqual(output, input, "The output must be equal to the input because there is no alphabet's characters to replace")
    }

    func test_EmptyString_Transform_TheFunctionReturnsTheSameEmptyString() {
        // Given
        let input = ""

        // When
        let output = sut.transform(text: input)

        // Then
        XCTAssertEqual(output, input, "The output must be equal to the input because there is no alphabet's characters to replace")
    }
}

ChallengeFourTests.defaultTestSuite.run()
