//
//  MockGetBlockList.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 28/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation
@testable import jserranoBlockOneiOSDevTest

final class MockGetBlockList: GetBlockList {
    struct MockError: Error {}
    
    private var executeInvocationsCounter = 0
    var mockExecute: ServiceResponse<([Block?], BlockListState)> = .failure(error: MockError())
    
    func execute(with blockID: String, completion: @escaping BlockListResponse) {
        executeInvocationsCounter += 1
        completion(mockExecute)
    }
    
    func executeInvocations() -> Int {
        return executeInvocationsCounter
    }
}
