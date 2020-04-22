/*:
 ***
 ### Letter Changes
 Have the function LetterChanges(str) take the str parameter being passed and modify it using the following algorithm. Replace every letter in the string with the letter following it in the alphabet (ie. c becomes d, z becomes a). Then capitalize every vowel in this new string (a, e, i, o, u) and finally return this modified string.
 
 ***
 */

import Foundation
import XCTest

extension String {
    
    private var shiftDictionary: [String : String] {
        ["a":"b", "b":"c", "c":"d", "d":"E",
         "e":"f", "f":"g", "g":"h", "h":"I",
         "i":"j", "j":"k", "k":"l", "l":"m",
         "m":"n", "n":"O", "o":"p", "p":"q",
         "q":"r", "r":"s", "s":"t", "t":"U",
         "u":"v", "v":"w", "w":"x", "x":"y",
         "y":"z", "z":"A"]
    }
    
    func shiftLetters() -> String {
        return self.map {
            return shiftDictionary[String($0)] ?? String($0)
        }
        .reduce("",+)
    }
}


class LetterChangesTest: XCTestCase {
    
    func testShiftLetters_givenZAndVowels_returnAAndCapitalizedVowels() {
        // GIVEN
        let input = "why is zvan bothering us?"
        let expected = "xIz jt AwbO cpUIfsjOh vt?"
        
        // WHEN
        let result = input.shiftLetters()
        
        // THEN
        XCTAssertEqual(expected, result, "For \(input) the expected result is \(expected)")
    }
    
    func testShifteLetters_givenVowelsAndSigns_returnCapitalizedVowelsAndSameSigns() {
        // GIVEN
        let input = "as you th*ink"
        let expected = "bt zpv UI*jOl"
        
        // WHEN
        let result = input.shiftLetters()
        
        // THEN
        XCTAssertEqual(expected, result, "For \(input) the expected result is \(expected)")
    }
            
}

LetterChangesTest.defaultTestSuite.run()

//: ***
//: [Previous](@previous) || [Next](@next)
