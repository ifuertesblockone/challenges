//
//  MockBlockService.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 28/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation
@testable import jserranoBlockOneiOSDevTest

final class MockBlockService: BlockService {
    struct MockError: Error {}
    
    private var getBlockInvocationsCounter = 0
    var mockGetBlockResponse: ServiceResponse<[Block?]> = .failure(error: MockError())
    
    func getBlock(blockID: String, completion: @escaping BlockResponse) {
        getBlockInvocationsCounter += 1
        completion(mockGetBlockResponse)
    }
    
    func getBlockInvocations() -> Int {
        return getBlockInvocationsCounter
    }
}
