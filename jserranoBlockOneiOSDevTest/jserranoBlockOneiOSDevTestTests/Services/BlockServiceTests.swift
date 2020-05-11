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
    
    static let mockBlockResponse: [String: Any] = ["timestamp": "mock_timestamp",
                                                   "producer": "mock_producer",
                                                   "previous": "mock_previous",
                                                   "producer_signature": "mock_producerSignature",
                                                   "transactions": [["status": "mock_status",
                                                                    "cpu_usage_us": 1,
                                                                    "net_usage_words": 0]],
                                                   "id": "mock_id",
                                                   "block_num": 1000]
    
    static let mockIncorrectBlockResponse: [String: Any] = ["id": "mock_id"]
    
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
        // Given
        urlSession.mockCreateBody = createMockBody()
        urlSession.mockMakeRequest = mockRequest()
        
        // When
        sut.getBlock(blockID: "mock_blockID") { _ in }
        
        // Then
        XCTAssertEqual(urlSession.getPerformTaskInvocations(),
                       1,
                       "The getPerformTask must be called to get the block")
    }
    
    func test_GetBlock_ServiceCallsURLSessionMakeRequestMethod() {
        // Given
        urlSession.mockCreateBody = createMockBody()
        
        // When
        sut.getBlock(blockID: "mock_blockID") { _ in }
        
        // Then
        XCTAssertEqual(urlSession.getMakeRequestInvocations(),
                       1,
                       "The makeRequest must be called to get the block")
    }
    
    func test_ServiceWorksAndInvalidRequest_GetBlock_PerformTaskReturnsAValidBlock() {
        // Given
        var blockServiceResponse: ServiceResponse<[Block?]>? = nil
        
        urlSession.mockCreateBody = nil
        urlSession.mockMakeRequest = nil
        
        // When
        sut.getBlock(blockID: "mock_blockID") { serviceResponse in
            blockServiceResponse = serviceResponse
        }
        
        // Then
        guard case .failure(let error) = blockServiceResponse else {
            XCTFail("The response must be failure because there is an error from makeRequest method of urlSession dependency")
            return
        }
        
        XCTAssertNotNil(error, "Error must not be nil because there was an error making the request")
    }
    
    func test_ServiceWorks_GetBlock_ServiceReturnsABlockCorrectly() {
        // Given
        var blockServiceResponse: ServiceResponse<[Block?]>? = nil
        let mockData = mockDataResponse()
        
        urlSession.mockCreateBody = createMockBody()
        urlSession.mockMakeRequest = mockRequest()
        urlSession.mockPerformTask = (data: mockData, response: nil, error: nil)
        
        // When
        sut.getBlock(blockID: "mock_blockID") { serviceResponse in
            blockServiceResponse = serviceResponse
        }
        
        // Then
        guard case .success(let blocks) = blockServiceResponse else {
            XCTFail("The response must be success because there is a valid block from the service")
            return
        }
        
        XCTAssertEqual(blocks.first??.id, Self.mockBlockResponse["id"] as? String ?? "", "The id must be equal to ID property of mockDataResponse because it is the response data.")
    }
    
    func test_ServiceDoesNotWork_GetBlock_ServiceReturnsAnError() {
        // Given
        struct MockError: Error {}
        var blockServiceResponse: ServiceResponse<[Block?]>? = nil
        
        urlSession.mockCreateBody = createMockBody()
        urlSession.mockMakeRequest = mockRequest()
        urlSession.mockPerformTask = (data: nil, response: nil, error: MockError())
        
        // When
        sut.getBlock(blockID: "mock_blockID") { serviceResponse in
            blockServiceResponse = serviceResponse
        }
        
        // Then
        guard case .failure(let error) = blockServiceResponse else {
            XCTFail("The response must be falilure because there is an error from urlSession dependency")
            return
        }
        
        XCTAssertNotNil(error, "The error must not be nil because there was an error from urlSession dependency")
    }
    
    func test_ServiceRetrievesIncorrectPayload_GetBlock_ServiceReturnsAnError() {
        // Given
        var blockServiceResponse: ServiceResponse<[Block?]>? = nil
        let mockData = mockIncorrectDataResponse()
        
        urlSession.mockCreateBody = createMockBody()
        urlSession.mockMakeRequest = mockRequest()
        urlSession.mockPerformTask = (data: mockData, response: nil, error: nil)
        
        // When
        sut.getBlock(blockID: "mock_blockID") { serviceResponse in
            blockServiceResponse = serviceResponse
        }
        
        // Then
        guard case .failure(let error) = blockServiceResponse else {
            XCTFail("The response must be failure because the payload from the service is invalid")
            return
        }
        
        XCTAssertNotNil(error, "The error must not be nil because there was an error from service payload")
    }
}

private extension BlockServiceTests {
    func mockDataResponse() -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: Self.mockBlockResponse, options: .prettyPrinted)
        } catch {
            return nil
        }
    }
    
    func mockIncorrectDataResponse() -> Data? {
        do {
            let mockBlockDataResponse = try JSONSerialization.data(withJSONObject: Self.mockIncorrectBlockResponse, options: .prettyPrinted)
            
            return mockBlockDataResponse
        } catch {
            return nil
        }
    }
    
    func mockRequest() -> URLRequest {
        return URLRequest(url: URL(string: "https://www.example.com")!)
    }
    
    func createMockBody() -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: ["block_num_or_id": "mock_id"], options: .prettyPrinted)
        } catch {
            return nil
        }
    }
}
