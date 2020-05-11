//
//  MockURLSession.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 30/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation
@testable import jserranoBlockOneiOSDevTest

final class MockURLSession: URLSessionProtocol {
    struct MockError: Error {}
    
    private var performTaskInvocationsCounter = 0
    private var createBodyInvocationsCounter = 0
    private var makeRequestInvocationsCounter = 0
    private var performTaskArguments: (URLRequest, URLTaskCompletion)?
    private var makeRequestArguments: (String, HTTPMethod, Data?)?
    private var createBodyArguments: [String: Any]?
    
    var mockPerformTask: (data: Data?, response: URLResponse?, error: Error?)?
    var mockMakeRequest: URLRequest?
    var mockCreateBody: Data?
    
    func performTask(with request: URLRequest, completion: @escaping URLTaskCompletion) {
        performTaskInvocationsCounter += 1
        performTaskArguments = (request, completion)
        
        guard let mockPerformTask = mockPerformTask else {
            return
        }
        
        completion(mockPerformTask.data, mockPerformTask.response, mockPerformTask.error)
    }
    
    func makeRequest(with endpoint: String, method: HTTPMethod, data: Data?) -> URLRequest? {
        makeRequestInvocationsCounter += 1
        makeRequestArguments = (endpoint, method, data)
        return mockMakeRequest
    }
    
    func createBody(with paramaters: [String : Any]) -> Data? {
        createBodyInvocationsCounter += 1
        createBodyArguments = paramaters
        return mockCreateBody
    }
    
    func getPerformTaskInvocations() -> Int {
        return performTaskInvocationsCounter
    }
    
    func getPerformTaskArguments() -> (URLRequest, URLTaskCompletion)? {
        return performTaskArguments
    }
    
    func getMakeRequestInvocations() -> Int {
        return makeRequestInvocationsCounter
    }
    
    func getMakeRequestArguments() -> (String, HTTPMethod, Data?)? {
        return makeRequestArguments
    }
}
