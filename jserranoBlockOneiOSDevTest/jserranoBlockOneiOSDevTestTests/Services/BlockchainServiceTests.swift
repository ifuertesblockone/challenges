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
    
    static let mockBlockInfoResponse: [String: Any] = ["server_version": "mock_server_version",
                                                       "chain_id": "mock_chain_id",
                                                       "head_block_num": 1000,
                                                       "head_block_id": "mock_head_block_id"]
    
    static let mockIncorrectBlockInfoResponse: [String: Any] = ["previous": "mock_previous"]
    
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
        // Given
        urlSession.mockMakeRequest = mockRequest()
        
        // When
        sut.getInfo { _ in }
        
        // Then
        XCTAssertEqual(urlSession.getPerformTaskInvocations(),
                       1,
                       "The getPerformTask must be called to get the blockchain info")
    }
    
    func test_GetInfo_ServiceCallsURLSessionMakeRequestMethod() {
        // When
        sut.getInfo { _ in }
        
        // Then
        XCTAssertEqual(urlSession.getMakeRequestInvocations(),
                       1,
                       "The makeRequest must be called to get the block")
    }
    
    func test_InvalidRequest_GetInfo_ServiceReturnsAnError() {
        // Given
        var blockchainServiceResponse: ServiceResponse<Blockchain?>? = nil
        
        urlSession.mockMakeRequest = nil
        
        // When
        sut.getInfo { serviceResponse in
            blockchainServiceResponse = serviceResponse
        }
        
        // Then
        guard case .failure(let error) = blockchainServiceResponse else {
            XCTFail("The response must be failure because there is an error from makeRequest method of urlSession dependency")
            return
        }
        
        XCTAssertNotNil(error, "Error must not be nil because there was an error making the request")
    }
    
    func test_ServiceWorks_GetInfo_ServiceReturnsTheBlockInfoCorrectly() {
        // Given
        var blockchainServiceResponse: ServiceResponse<Blockchain?>? = nil
        let mockData = mockDataResponse()
        
        urlSession.mockMakeRequest = mockRequest()
        urlSession.mockPerformTask = (data: mockData, response: nil, error: nil)
        
        // When
        sut.getInfo { serviceResponse in
            blockchainServiceResponse = serviceResponse
        }
        
        // Then
        guard case .success(let blockchain) = blockchainServiceResponse else {
            XCTFail("The response must be success because there is a valid block from the service")
            return
        }
        
        XCTAssertEqual(blockchain?.headBlockId,
                       Self.mockBlockInfoResponse["head_block_id"] as? String ?? "",
                       "The id must be equal to ID property of mockDataResponse because it is the response data.")
    }
    
    func test_ServiceDoesNotWork_GetInfo_ServiceReturnsAnError() {
        // Given
        struct MockError: Error {}
        var blockchainServiceResponse: ServiceResponse<Blockchain?>? = nil
        
        urlSession.mockMakeRequest = mockRequest()
        urlSession.mockPerformTask = (data: nil, response: nil, error: MockError())
        
        // When
        sut.getInfo { serviceResponse in
            blockchainServiceResponse = serviceResponse
        }
        
        // Then
        guard case .failure(let error) = blockchainServiceResponse else {
            XCTFail("The response must be falilure because there is an error from urlSession dependency")
            return
        }
        
        XCTAssertNotNil(error, "The error must not be nil because there was an error from urlSession dependency")
    }
    
    func test_ServiceRetrievesIncorrectPayload_GetInfo_ServiceReturnsAnError() {
        // Given
        var blockchainServiceResponse: ServiceResponse<Blockchain?>? = nil
        let mockData = mockIncorrectDataResponse()
        
        urlSession.mockMakeRequest = mockRequest()
        urlSession.mockPerformTask = (data: mockData, response: nil, error: nil)
        
        // When
        sut.getInfo { serviceResponse in
            blockchainServiceResponse = serviceResponse
        }
        
        // Then
        guard case .failure(let error) = blockchainServiceResponse else {
            XCTFail("The response must be failure because the payload from the service is invalid")
            return
        }
        
        XCTAssertNotNil(error, "The error must not be nil because there was an error from service payload")
    }
}

private extension BlockchainServiceTests {
    func mockDataResponse() -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: Self.mockBlockInfoResponse, options: .prettyPrinted)
        } catch {
            return nil
        }
    }
    
    func mockIncorrectDataResponse() -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: Self.mockIncorrectBlockInfoResponse, options: .prettyPrinted)
        } catch {
            return nil
        }
    }
    
    func mockRequest() -> URLRequest {
        return URLRequest(url: URL(string: "https://www.example.com")!)
    }
}
