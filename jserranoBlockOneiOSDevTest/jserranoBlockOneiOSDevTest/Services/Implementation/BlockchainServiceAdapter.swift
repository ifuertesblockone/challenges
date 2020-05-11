//
//  BlockchainServiceAdapter.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

final class BlockchainServiceAdapter {
    struct Constants {
        static let getInfoEndpoint = "https://eos.greymass.com:443/v1/chain/get_info"
    }
    
    struct Dependencies {
        var urlSession: URLSessionProtocol = URLSessionAdapter()
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
}

extension BlockchainServiceAdapter: BlockchainService {
    func getInfo(completion: @escaping BlockchainInfoResponse) {
        guard let request = dependencies.urlSession.makeRequest(with: Constants.getInfoEndpoint, method: .post, data: nil)
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

private extension BlockchainServiceAdapter {
    func handleResponse(data: Data?, error: Error?, completion: @escaping BlockchainInfoResponse) {
        guard let error = error else {
            guard
                let data = data,
                let blockchainInfo = parser(withData: data)
            else {
                completion(.failure(error: BlockchainError.unknownError))
                return
            }
            
            completion(.success(response: blockchainInfo))
            return
        }
        
        completion(.failure(error: error))
    }
    
    func parser(withData data: Data) -> Blockchain? {
        do {
            let decoder = JSONDecoder()
            let blockchainInfo = try decoder.decode(Blockchain.self, from: data)
            
            return blockchainInfo
        } catch let error {
            print("Parse error: \(error)")
            return nil
        }
    }
}
