//
//  GetBlockListAdapter.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

final class GetBlockListAdapter: GetBlockList {
    struct Constants {
        static let limit = 20
    }
    struct Dependencies {
        var blockListService: BlockService = BlockServiceAdapter()
    }
    
    let dependencies: Dependencies
    var blockList: [Block?] = []
    
    var isBlockListCompleted: Bool {
        return blockList.count == Constants.limit
    }
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
    
    func execute(with blockID: String, completion: @escaping BlockListResponse) {
        handleBlockList(blockID: blockID, completion: completion)
    }
}

private extension GetBlockListAdapter {
    func handleBlockList(blockID: String, completion: @escaping BlockListResponse) {
        dependencies.blockListService.getBlock(blockID: blockID) {[weak self] blockResponse in
            switch blockResponse {
            case .success(let blocks):
                self?.handleSuccessBlockResponse(blocks: blocks, completion: completion)
            case .failure(let error):
                self?.handleFailureBlockResponse(error: error, completion: completion)
            }
        }
    }
    
    func handleSuccessBlockResponse(blocks: [Block?], completion: @escaping BlockListResponse) {
        guard !isBlockListCompleted else {
            resetBlockList()
            return
        }
        
        guard
            let block = blocks.first,
            let previousBlockID = block?.previous
        else {
            handleFailureBlockResponse(error: BlockchainError.invalidInformation, completion: completion)
            return
        }
        
        blockList.append(block)
        
        completion(.success(response: (blockList, (isBlockListCompleted ? .completed : .pending))))
        handleBlockList(blockID: previousBlockID, completion: completion)
    }
    
    func handleFailureBlockResponse(error: Error, completion: @escaping BlockListResponse) {
        guard blockList.count > 0 else {
            completion(.failure(error: error))
            return
        }
        
        completion(.success(response: (blockList, .stopped)))
        resetBlockList()
    }
    
    func resetBlockList() {
        blockList.removeAll()
    }
}
