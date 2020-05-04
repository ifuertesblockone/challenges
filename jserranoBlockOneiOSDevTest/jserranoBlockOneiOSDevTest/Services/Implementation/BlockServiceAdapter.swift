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
        
        guard let request = makeRequest(with: .post, data: createBody(with: parameters)) else {
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
    func createBody(with paramaters: [String: Any]) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: paramaters, options: .prettyPrinted)
        } catch {
            return nil
        }
    }
    func makeRequest(with method: HTTPMethod = .get, data: Data?) -> URLRequest? {
        guard let url = URL(string: Constants.blockEndpoint) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = data
        request.cachePolicy = .reloadIgnoringCacheData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func handleResponse(data: Data?, error: Error?, completion: @escaping BlockResponse) {
        guard let error = error else {
            guard let data = data else {
                completion(.failure(error: BlockchainError.unknownError))
                return
            }
            
            let block = parser(withData: data)
            
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
