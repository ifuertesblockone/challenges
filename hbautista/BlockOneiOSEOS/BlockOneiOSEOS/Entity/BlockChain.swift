//
//  BlockChain.swift
//  BlockOneiOSEOS
//
//  Created by Henry Bautista on 27/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import Foundation

// MARK: - Main BlockChain Info
struct BlockChain: Codable {
    let serverVersion, chainID: String?
    let headBlockNum, lastIrreversibleBlockNum: Int?
    let lastIrreversibleBlockID, headBlockID, headBlockTime, headBlockProducer: String?
    let virtualBlockCPULimit, virtualBlockNetLimit, blockCPULimit, blockNetLimit: Int?
    let serverVersionString: String?
    let forkDBHeadBlockNum: Int?
    let forkDBHeadBlockID, serverFullVersionString: String?

    enum CodingKeys: String, CodingKey {
        case serverVersion = "server_version"
        case chainID = "chain_id"
        case headBlockNum = "head_block_num"
        case lastIrreversibleBlockNum = "last_irreversible_block_num"
        case lastIrreversibleBlockID = "last_irreversible_block_id"
        case headBlockID = "head_block_id"
        case headBlockTime = "head_block_time"
        case headBlockProducer = "head_block_producer"
        case virtualBlockCPULimit = "virtual_block_cpu_limit"
        case virtualBlockNetLimit = "virtual_block_net_limit"
        case blockCPULimit = "block_cpu_limit"
        case blockNetLimit = "block_net_limit"
        case serverVersionString = "server_version_string"
        case forkDBHeadBlockNum = "fork_db_head_block_num"
        case forkDBHeadBlockID = "fork_db_head_block_id"
        case serverFullVersionString = "server_full_version_string"
    }
}
