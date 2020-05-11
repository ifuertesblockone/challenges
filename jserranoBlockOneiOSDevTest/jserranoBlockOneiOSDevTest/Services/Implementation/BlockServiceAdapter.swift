//
//  BlockServiceAdapter.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

final class BlockServiceAdapter {
    struct Constants {
        static let blockEndpoint = "https://eos.greymass.com:443/v1/chain/get_block"
    }
    
    struct Dependencies {
        var urlSession: URLSessionProtocol = URLSessionAdapter()
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
}

extension BlockServiceAdapter: BlockService {
    func getBlock(blockID: String, completion: @escaping BlockResponse) {
        let parameters = ["block_num_or_id": blockID]
        
        guard let request = dependencies.urlSession.makeRequest(with: Constants.blockEndpoint,
                                                                method: .post,
                                                                data: dependencies.urlSession.createBody(with: parameters))
        else {
            completion(.failure(error: BlockchainError.unknownError))
            return
        }
        
        dependencies.urlSession.performTask(with: request) { [weak self] (data, response, error) in
            guard let strongSelf = self else {
                completion(.failure(error: BlockchainError.unknownError))
                return
            }
            
            strongSelf.handleResponse(data: data, error: error, completion: completion)
        }
    }
}

private extension BlockServiceAdapter {
    func handleResponse(data: Data?, error: Error?, completion: @escaping BlockResponse) {
        guard let error = error else {
            guard
                let data = data,
                let block = parser(withData: data)
            else {
                completion(.failure(error: BlockchainError.unknownError))
                return
            }
            
            completion(.success(response: [block]))
            return
        }
        
        completion(.failure(error: error))
    }
    
    func parser(withData data: Data) -> Block? {
        do {
            let decoder = JSONDecoder()
            var block = try decoder.decode(Block.self, from: data)
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
            block.rawJsonResponse = jsonResponse as AnyObject
            return block
        } catch let error {
            print("Parse error: \(error)")
            return nil
        }
    }
}
