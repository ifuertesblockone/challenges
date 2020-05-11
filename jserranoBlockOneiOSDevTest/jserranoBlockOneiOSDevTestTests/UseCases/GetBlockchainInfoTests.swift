//
//  GetBlockchainInfoTests.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 28/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import XCTest
@testable import jserranoBlockOneiOSDevTest

final class GetBlockchainInfoTests: XCTestCase {
    typealias `Self` = GetBlockchainInfoTests
    
    struct MockError: Error {}
    
    var blockchainService: MockBlockchainService!
    var sut: GetBlockchainInfoAdapter!
    
    override func setUp() {
        super.setUp()
        blockchainService = MockBlockchainService()
        
        sut = GetBlockchainInfoAdapter(dependencies: .init(blockchainService: blockchainService))
    }
    
    override func tearDown() {
        sut = nil
        blockchainService = nil
    }
    
    func test_BlockchainServiceWorks_Execute_ReturnsTheBlockchainInfo() {
        // Given
        var blockchainInfoResponse: ServiceResponse<Blockchain?> = .failure(error: MockError())
        let mockBlockChainInfo = Blockchain(serverVersion: "mock_serverVersion",
                                        chainId: "mock_chainId",
                                        headBlockNum: 0,
                                        headBlockId: "mock_headBlockId")
        
        blockchainService.mockGetInfoResponse = .success(response: mockBlockChainInfo)
        
        // When
        sut.execute { blockchainResponse in
            blockchainInfoResponse = blockchainResponse
        }
        
        // Then
        guard case .success(let blockchainInfo) = blockchainInfoResponse else {
            XCTFail("blockchainInfoResponse must be success because the service response was valid.")
            return
        }
        
        XCTAssertEqual(blockchainInfo, mockBlockChainInfo, "The blockchainInfo must be equal to the mockBlockChainInfo because it was given as service response.")
    }
    
    func test_BlockchainServiceDoesNotWork_Execute_ReturnsAnServiceError() {
        // Given
        var blockchainInfoResponse: ServiceResponse<Blockchain?> = .failure(error: MockError())
        blockchainService.mockGetInfoResponse = .failure(error: MockError())
        
        // When
        sut.execute { blockchainResponse in
            blockchainInfoResponse = blockchainResponse
        }
        
        // Then
        guard case .failure(_) = blockchainInfoResponse else {
            XCTFail("The blockchain service response must be equal to failure because it was the value returned by the dependency")
            return
        }
        
        XCTAssertTrue(blockchainService.getInfoInvocations() > 0, "The blockchainService must be called as part of dependencies to get the blockchain infomation")
    }
}
