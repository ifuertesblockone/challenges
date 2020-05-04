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
    private var performTaskArguments: (URLRequest, URLTaskCompletion)?
    
    func performTask(with request: URLRequest, completion: @escaping URLTaskCompletion) {
        performTaskInvocationsCounter += 1
        performTaskArguments = (request, completion)
    }
    
    func getPerformTaskInvocations() -> Int {
        return performTaskInvocationsCounter
    }
    
    func getPerformTaskArguments() -> (URLRequest, URLTaskCompletion)? {
        return performTaskArguments
    }
}
