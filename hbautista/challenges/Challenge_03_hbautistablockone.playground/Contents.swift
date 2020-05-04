//
//  Challenge_03_hbautistablockone.swift
//  Encryptor : This class provides one method to encrypt a string moving next one letter over the alphabet and set to Uppercase the vowels
//
//  Created by Henry Bautista on 22/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import Foundation
import XCTest

protocol StringFunctions: class {
    func encrypt(source: String) -> (String)
}

class Encryptor {
    // Defines the Unicode base Characters range
    private let letters = UInt32("a") ... UInt32("z")
    private var alphabet: String

    // MARK: Constructor. assign the defined chars as string, occurs once.
    init() {
        alphabet = String.UnicodeScalarView(letters.compactMap(UnicodeScalar.init)).description
    }
    
    // MARK: Transform. Private function to transform input char to next output char & uppercase for vowels
    private final func transform(char: Character) -> (Character) {
        var result: Character = char
        
        switch (char) {
            case "z" , "Z":
                return "A"
            default:
                guard let to = alphabet.firstIndex(of: char) else {
                    return char
                }
                let idx = alphabet.distance(from: alphabet.startIndex, to: to)
                result = Character(alphabet.map() { String($0) }[ idx + 1 ])
        }
        
        switch (result) {
            case "e", "i", "o", "u" :
                result = Character(String(result).uppercased())
            default:
                return result
        }
        
        return result
    }
}

extension Encryptor : StringFunctions {
    func encrypt(source: String) -> (String) {
        return String(source.map { transform(char: $0) })
    }
}

class ChallengeTests: XCTestCase {
    var encryptor: Encryptor!
    
    // MARK: Default test scope
    override func setUp() {
        super.setUp()
        encryptor = Encryptor()
    }

    override func tearDown() {
        encryptor = nil
        super.tearDown()
    }
    
    // MARK: Begining of the Use Case Tests
    func test_Encryptor_Encrypt_Scenario_01() {
        // GIVEN
        let input = "as you th*ink"
        
        // WHEN
        let expected = "bt zpv UI*jOl"
        
        // THEN
        XCTAssertEqual(encryptor.encrypt(source: input), expected, "The expected result for \(input)  is \(expected)")
    }
    
    func test_Encryptor_Encrypt_Scenario_02() {
        // GIVEN
        let input = "why is zvan bothering us?"
        
        // WHEN
        let expected = "xIz jt AwbO cpUIfsjOh vt?"
        
        // THEN
        XCTAssertEqual(encryptor.encrypt(source: input), expected, "The expected result for \(input)  is \(expected)")
    }
    
    func test_Encryptor_Encrypt_empty() {
        // GIVEN
        let input = ""
        
        // WHEN
        let expected = ""
        
        // THEN
        XCTAssertEqual(encryptor.encrypt(source: input), expected, "The expected result for \(input)  is \(expected)")
    }
}

ChallengeTests.defaultTestSuite.run()
