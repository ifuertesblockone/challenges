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
    var headBlockTime: String
    var headBlockProducer: String
    var lastIrreversibleBlockNum: Int
    var lastIrreversibleBlockId: String
    var virtualBlockCpuLimit: Int
    var virtualBlockNetLimit: Int
    var blockCpuLimit: Int
    var blockNetLimit: Int
    var serverVersionString: String
    var forkDbHeadBlockNum: Int
    var forkBbHeadBlockId: String
    
    enum CodingKeys: String, CodingKey, Equatable {
        case serverVersion = "server_version"
        case chainId = "chain_id"
        case headBlockNum = "head_block_num"
        case headBlockId = "head_block_id"
        case headBlockTime = "head_block_time"
        case headBlockProducer = "head_block_producer"
        case lastIrreversibleBlockNum = "last_irreversible_block_num"
        case lastIrreversibleBlockId = "last_irreversible_block_id"
        case virtualBlockCpuLimit = "virtual_block_cpu_limit"
        case virtualBlockNetLimit = "virtual_block_net_limit"
        case blockCpuLimit = "block_cpu_limit"
        case blockNetLimit = "block_net_limit"
        case serverVersionString = "server_version_string"
        case forkDbHeadBlockNum = "fork_db_head_block_num"
        case forkBbHeadBlockId = "fork_db_head_block_id"
    }
}
