//
//  GetBlockListTests.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 28/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import XCTest
@testable import jserranoBlockOneiOSDevTest

final class GetBlockListTests: XCTestCase {
    typealias `Self` = GetBlockListTests
    
    struct MockError: Error {}
    
    var blockService: MockBlockService!
    var sut: GetBlockListAdapter!
    
    override func setUp() {
        super.setUp()
        blockService = MockBlockService()
        
        sut = GetBlockListAdapter(dependencies: .init(blockListService: blockService))
    }
    
    override func tearDown() {
        sut = nil
        blockService = nil
    }
    
    func test_BlockServiceWorks_Execute_ReturnsTheBlockList() {
        // Given
        let numberOfExpectedBlock = 20
        var blockListResponse: ServiceResponse<([Block?], BlockListState)> = .failure(error: MockError())
        let mockBlockList = [Block(timestamp: "mock_timestamp",
                                   producer: "mock_producer",
                                   previous: "mock_previous",
                                   producerSignature: "mock_producerSignature",
                                   transactions: [Block.Transaction(status: "mock_status",
                                                                    cpuUsageUs: 0,
                                                                    netUsageWords: 0)],
                                   id: "mock_id",
                                   blockNum: 0,
                                   rawJsonResponse: nil)]
        
        blockService.mockGetBlockResponse = .success(response: mockBlockList)
        
        // When
        sut.execute(with: "mock_PreviousBlockID") { blockListServiceResponse in
            blockListResponse = blockListServiceResponse
        }
        
        // Then
        guard case .success(response: (let blockList, let blockListState)) = blockListResponse else {
            XCTFail("blockList response must be success because this was the value returned by the dependency")
            return
        }
        
        XCTAssertEqual(blockList.count, numberOfExpectedBlock, "The number of blocks must be equal to numberOfExpectedBlock because this is the limit to fetch")
        XCTAssertEqual(blockListState, .completed, "The blockListState must be completed because the block respose has been successful")
        XCTAssertTrue(blockService.getBlockInvocations() > 0, "The blockService must be called as part of dependencies to fetch the blockList")
    }
    
    func test_ThereIsNoAValidBlock_Execute_BlockListResponseWithError() {
        // Given
        var blockListResponse: ServiceResponse<([Block?], BlockListState)> = .failure(error: MockError())
        let mockBlockList: [Block?] = [nil]
        
        blockService.mockGetBlockResponse = .success(response: mockBlockList)
        
        // When
        sut.execute(with: "mock_PreviousBlockID") { blockListServiceResponse in
            blockListResponse = blockListServiceResponse
        }
        
        // Then
        guard case .failure(_) = blockListResponse else {
            XCTFail("blockList response must be failure because there is no a valid block")
            return
        }
        
        XCTAssertTrue(blockService.getBlockInvocations() > 0, "The blockService must be called as part of dependencies to fetch the blockList")
    }
    
    func test_BlockServiceDoesNotWork_Execute_ReturnsAnServiceError() {
        // Given
        var blockListResponse: ServiceResponse<([Block?], BlockListState)> = .failure(error: MockError())
        blockService.mockGetBlockResponse = .failure(error: MockError())

        // When
        sut.execute(with: "mock_PreviousBlockID") { blockListServiceResponse in
            blockListResponse = blockListServiceResponse
        }

        // Then
        guard case .failure(_) = blockListResponse else {
            XCTFail("BlockList response must be equal to failure because the blockService returned a failure response")
            return
        }

        XCTAssertTrue(blockService.getBlockInvocations() > 0, "The blockService must be called as part of dependencies to fetch the blockList")
    }
}
