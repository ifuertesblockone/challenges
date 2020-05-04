//
//  BlockchainServiceTests.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 30/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import XCTest
@testable import jserranoBlockOneiOSDevTest

final class BlockchainServiceTests: XCTestCase {
    typealias `Self` = BlockchainServiceTests
    
    var urlSession: MockURLSession!
    
    var sut: BlockchainServiceAdapter!
    
    override func setUp() {
        super.setUp()
        urlSession = MockURLSession()
        
        sut = BlockchainServiceAdapter(dependencies: .init(urlSession: urlSession))
    }
    
    override func tearDown() {
        sut = nil
        urlSession = nil
    }
    
    func test_GetInfo_ServiceCallsURLSessionPerformTaskMethod() {
        // When
        sut.getInfo { _ in }
        
        // Then
        XCTAssertEqual(urlSession.getPerformTaskInvocations(),
                       1,
                       "The getPerformTask must be called to get the blockchain info")
    }
}
