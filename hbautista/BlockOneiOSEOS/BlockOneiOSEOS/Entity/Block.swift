//
//  Block.swift
//  BlockOneiOSEOS
//
//  Created by Henry Bautista on 28/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import Foundation

// MARK: - Block
struct Block: Codable, Identifiable {
    let timestamp, producer: String
    let confirmed: Int
    let previous, transaction_mroot, action_mroot: String
    let schedule_version: Int
    let new_producers: String?
    let producer_signature: String
    let transactions: [TransactionElement]
    let id: String
    let block_num, ref_block_prefix: Int

    enum CodingKeys: String, CodingKey {
        case timestamp, producer, confirmed, previous
        case transaction_mroot = "transaction_mroot"
        case action_mroot = "action_mroot"
        case schedule_version = "schedule_version"
        case new_producers = "new_producers"
        case producer_signature = "producer_signature"
        case transactions, id
        case block_num = "block_num"
        case ref_block_prefix = "ref_block_prefix"
    }
}


// MARK: - TransactionElement
struct TransactionElement: Codable {
    let status: String?
    let cpu_usage_us, net_usage_words: Int?
    let trx: TrxUnion?

    enum CodingKeys: String, CodingKey {
        case trx
        case status
        case cpu_usage_us = "cpu_usage_us"
        case net_usage_words = "net_usage_words"
    }
}

// MARK: - trx - TrxUnion
struct TrxUnion: Codable {
    var stringValue: String?
    var classValue: TrxClass?
    var isString: Bool

    init(from decoder: Decoder) throws {
        let container =  try decoder.singleValueContainer()
        self.isString = true
        if (try? container.decode(TrxClass.self)) != nil {
            self.isString = false
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if self.isString {
            try container.encode(stringValue)
        } else {
            try container.encode(classValue)
        }
    }
}

// MARK: - TrxClass
struct TrxClass: Codable {
    let id: String?
    let signatures: [String]?
    let compression: String?
    let packed_context_free_data: String?
    let context_free_data: [String]?
    let packed_trx: String?
    let transaction: TrxTransaction?
    
    enum CodingKeys: String, CodingKey {
        case id, signatures, compression
        case packed_context_free_data = "packed_context_free_data"
        case context_free_data = "context_free_data"
        case packed_trx = "packed_trx"
        case transaction
        
    }
}

// MARK: - TrxTransaction
struct TrxTransaction: Codable {
    let expiration: String?
    let ref_block_num, ref_block_prefix, max_net_usage_words, max_cpu_usage_ms: Int?
    let delay_sec: Int?
    let context_free_actions: [String]?
    let actions: [Action]

    enum CodingKeys: String, CodingKey {
        case expiration
        case ref_block_num = "ref_block_num"
        case ref_block_prefix = "ref_block_prefix"
        case max_net_usage_words = "max_net_usage_words"
        case max_cpu_usage_ms = "max_cpu_usage_ms"
        case delay_sec = "delay_sec"
        case context_free_actions = "context_free_actions"
        case actions
    }
}

// MARK: - Action
struct Action: Codable {
    let account, name: String
    let authorization: [Authorization]
    let data: DataClass
    let hex_data: String

    enum CodingKeys: String, CodingKey {
        case account, name, authorization, data
        case hex_data = "hex_data"
    }
}

// MARK: - Authorization
struct Authorization: Codable {
    let actor, permission: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let label_, hash, address: String
    let category, size: Int

    enum CodingKeys: String, CodingKey {
        case label_ = "label_"
        case hash, address, category, size
    }
}
