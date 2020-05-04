//
//  BlockServiceTests.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 30/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import XCTest
@testable import jserranoBlockOneiOSDevTest

final class BlockServiceTests: XCTestCase {
    typealias `Self` = BlockServiceTests
    
    var urlSession: MockURLSession!
    
    var sut: BlockServiceAdapter!
    
    override func setUp() {
        super.setUp()
        urlSession = MockURLSession()
        
        sut = BlockServiceAdapter(dependencies: .init(urlSession: urlSession))
    }
    
    override func tearDown() {
        sut = nil
        urlSession = nil
    }
    
    func test_GetBlock_ServiceCallsURLSessionPerformTaskMethod() {
        // When
        sut.getBlock(blockID: "mock_blockID") { _ in }
        
        // Then
        XCTAssertEqual(urlSession.getPerformTaskInvocations(),
                       1,
                       "The getPerformTask must be called to get the block")
    }
}
