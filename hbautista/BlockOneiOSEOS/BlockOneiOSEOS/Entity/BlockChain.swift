//
//  BlockChain.swift
//  BlockOneiOSEOS
//
//  Created by Henry Bautista on 27/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import Foundation

// MARK: - Main BlockChain Info
struct BlockChain: Decodable {
    let server_version, chain_id: String?
    let head_block_num, last_irreversible_block_num: Int?
    let last_irreversible_block_id,head_block_id, head_block_time, head_block_producer: String?
    let virtual_block_cpu_limit, virtual_block_net_limit, block_cpu_limit, block_net_limit: Int?
    let server_version_string: String?
    let fork_db_head_block_num: Int?
    let fork_db_head_block_id, server_full_version_string: String?
}
