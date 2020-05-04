//
//  MockBlockchainService.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 28/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation
@testable import jserranoBlockOneiOSDevTest

final class MockBlockchainService: BlockchainService {
    struct MockError: Error {}
    
    private var getInfoInvocationCounter: Int = 0
    var mockGetInfoResponse: ServiceResponse<Blockchain?> = .failure(error: MockError())
    
    func getInfo(completion: @escaping BlockchainInfoResponse) {
        getInfoInvocationCounter += 1
        completion(mockGetInfoResponse)
    }
    
    func getInfoInvocations() -> Int {
        return getInfoInvocationCounter
    }
}
