import Foundation
import XCTest

/*
 ### Challenge 004

 Create a function that takes a String parameter and modify it following these rules

 - Change every letter in the string with the next in the alphabet (ie. d -> e, z -> a).
 - Every vowel in this new string (a, e, i, o, u) capitalize it
 - Return this updated string.

 #### Examples

 Input: "as you th*ink"
 Output: bt zpv UI*jOl

 Input: "why is zvan bothering us?"
 Output: xIz jt AwbO cpUIfsjOh vt?
 */

final class StringModifier {
    func lettersToFollowingAndCapitalizeVowels(using text: String) -> String {
        var output = ""
        text.map {
            if $0.isLetter {
                let nextLetter = $0.getFollowingLetter()
                if nextLetter.isVowel() {
                    output.append(nextLetter.uppercased())
                } else {
                    output.append(nextLetter)
                }
            } else {
                output.append($0)
            }
        }
        return output
    }
}

extension Character {
    func isVowel() -> Bool {
        let vowelsSet: [String] = ["a", "e", "i", "o", "u"]
        return vowelsSet.contains(self.lowercased())
    }
    
    func getFollowingLetter() -> Character {
        if !self.isLetter {
            return self
        }
        switch self {
        case "z":
            return Character("a")
        case "Z":
            return Character("A")
        default:
            guard let asciiValue = self.asciiValue else {
                return self
            }
            let newChar = Character(UnicodeScalar(asciiValue + 1))
            return newChar
        }
    }
}

final class StringModifierTests: XCTestCase {
    
    var sut: StringModifier!
    
    override func setUp() {
        super.setUp()
        sut = StringModifier()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Tests for function lettersToFollowingAndCapitalizeVowels()
    
    
    func test_InputIsStringSet_CallingLettersToFollowingAndCapitalizeVowels_ShouldReturnNextLetterAndVowelCapitalized_case1() {
        // Given
        let stringSet = "as you th*ink"
        
        // When
        let outputSet = sut.lettersToFollowingAndCapitalizeVowels(using: stringSet)
        
        // Then
        XCTAssertEqual(outputSet, "bt zpv UI*jOl", "Function lettersToFollowingAndCapitalizeVowels should return 'as you th*ink'")
    }
    
    func test_InputIsStringSet_CallingLettersToFollowingAndCapitalizeVowels_ShouldReturnNextLetterAndVowelCapitalized_case2() {
        // Given
        let stringSet = "why is zvan bothering us?"
        
        // When
        let outputSet = sut.lettersToFollowingAndCapitalizeVowels(using: stringSet)
        
        // Then
        XCTAssertEqual(outputSet, "xIz jt AwbO cpUIfsjOh vt?", "Function lettersToFollowingAndCapitalizeVowels should return 'EfIjA' for input 'why is zvan bothering us?'")
    }
    
    func test_InputIsABCUppercased_CallingLettersToFollowingAndCapitalizeVowels_ShouldReturnBCD() {
        // Given
        let stringSet = "ABC"
        
        // When
        let outputSet = sut.lettersToFollowingAndCapitalizeVowels(using: stringSet)
        
        // Then
        XCTAssertEqual(outputSet, "BCD", "Function lettersToFollowingAndCapitalizeVowels should return 'BCD' for input 'ABC'")
    }
    
    func test_InputIsDZHIUppercased_CallingLettersToFollowingAndCapitalizeVowels_ShouldReturnEAIJ() {
        // Given
        let stringSet = "DZHI"
        
        // When
        let outputSet = sut.lettersToFollowingAndCapitalizeVowels(using: stringSet)
        
        // Then
        XCTAssertEqual(outputSet, "EAIJ", "Function lettersToFollowingAndCapitalizeVowels should return 'EAIJ' for input 'DZHI'")
    }
    
    func test_InputIsDEHIZLowercased_CallingLettersToFollowingAndCapitalizeVowels_ShouldReturnEfIja() {
        // Given
        let stringSet = "dehiz"
        
        // When
        let outputSet = sut.lettersToFollowingAndCapitalizeVowels(using: stringSet)
        
        // Then
        XCTAssertEqual(outputSet, "EfIjA", "Function lettersToFollowingAndCapitalizeVowels should return 'EfIjA' for input 'dehiz'")
    }
}

final class CharacterExtensionTests: XCTestCase {
    
    // MARK: Tests for function isVowel()
    
    func test_LetterA_isVowel_ShouldReturnTrue() {
        // Given
        let letter: Character = "A"
        
        // When
        let isVowel = letter.isVowel()
        
        // Then
        XCTAssertEqual(isVowel, true, "Function isVowel() should return true for input letter 'A'")
    }
    
    func test_LetterB_isVowel_ShouldReturnTrue() {
        // Given
        let letter: Character = "B"
        
        // When
        let isVowel = letter.isVowel()
        
        // Then
        XCTAssertEqual(isVowel, false, "Function isVowel() should return false for input letter 'B'")
    }
    
    func test_Char$_isVowel_ShouldReturnTrue() {
        // Given
        let char: Character = "$"
        
        // When
        let isVowel = char.isVowel()
        
        // Then
        XCTAssertEqual(isVowel, false, "Function isVowel() should return false for input character '$'")
    }
    
    // Mark: Tests for function getFollowingLetter()
    
    func test_LetterDLowercased_GetFollowingLetter_ShouldReturnELowercased() {
        // Given
        let letter: Character = "d"
        
        // When
        let nextLetter = letter.getFollowingLetter()
        
        // Then
        XCTAssertEqual(nextLetter, "e", "Function getFollowingLetter() should return 'e' for input 'd'")
    }
    
    func test_LetterA_GetFollowingLetter_ShouldReturnB() {
        // Given
        let letter: Character = "A"
        
        // When
        let nextLetter = letter.getFollowingLetter()
        
        // Then
        XCTAssertEqual(nextLetter, "B", "Function getFollowingLetter() should return 'B' for input 'A'")
    }
    
    func test_LetterZLowercased_GetFollowingLetter_ShouldReturnALowercased() {
        // Given
        let letter: Character = "z"
        
        // When
        let nextLetter = letter.getFollowingLetter()
        
        // Then
        XCTAssertEqual(nextLetter, "a", "Function getFollowingLetter() should return 'a' for input 'z'")
    }
    
    func test_LetterZUppercased_GetFollowingLetter_ShouldReturnAUppercased() {
        // Given
        let letter: Character = "Z"
        
        // When
        let nextLetter = letter.getFollowingLetter()
        
        // Then
        XCTAssertEqual(nextLetter, "A", "Function getFollowingLetter() should return 'A' for input 'Z'")
    }
    
    func test_NumericValue_GetFollowingLetter_ShouldReturnSameNumber() {
        // Given
        let number: Character = "3"
        
        // When
        let nextLetter = number.getFollowingLetter()
        
        // Then
        XCTAssertEqual(nextLetter, "3", "Function getFollowingLetter() should return the same character if input is not letter, input '3' ouput should be '3'")
    }
    
    func test_SpecialChar_GetFollowingLetter_ShouldReturnSameChar() {
        // Given
        let specialChar: Character = "%"
        
        // When
        let nextLetter = specialChar.getFollowingLetter()
        
        // Then
        XCTAssertEqual(nextLetter, "%", "Function getFollowingLetter() should return the same character if input is not letter, input '%' ouput should be '%'")
    }
}

CharacterExtensionTests.defaultTestSuite.run()
StringModifierTests.defaultTestSuite.run()
