//
//  Blockchain.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

struct Blockchain: Codable, Equatable {
    var serverVersion: String
    var chainId: String
    var headBlockNum: Int
    var headBlockId: String
    
    enum CodingKeys: String, CodingKey, Equatable {
        case serverVersion = "server_version"
        case chainId = "chain_id"
        case headBlockNum = "head_block_num"
        case headBlockId = "head_block_id"
    }
}
