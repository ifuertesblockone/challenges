//
//  GetBlockchainInfoAdapter.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 27/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

final class GetBlockchainInfoAdapter: GetBlockchainInfo {
    struct Dependencies {
        var blockchainService: BlockchainService = BlockchainServiceAdapter()
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
    
    func execute(completion: @escaping BlockchainInfoResponse) {
        dependencies.blockchainService.getInfo(completion: completion)
    }
}
