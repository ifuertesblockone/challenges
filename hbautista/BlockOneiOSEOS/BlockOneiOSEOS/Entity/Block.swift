//
//  Block.swift
//  BlockOneiOSEOS
//
//  Created by Henry Bautista on 28/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import Foundation

// MARK: - Block
struct Block: Codable,Identifiable {
    let timestamp, producer: String?
    let confirmed: Int?
    let previous, transactionMroot, actionMroot: String?
    let scheduleVersion: Int?
    let newProducers: String?
    let producerSignature: String?
    let transactions: [TransactionElement]?
    let id: String?
    let blockNum, refBlockPrefix: Int?

    enum CodingKeys: String, CodingKey {
        case timestamp, producer, confirmed, previous
        case transactionMroot = "transaction_mroot"
        case actionMroot = "action_mroot"
        case scheduleVersion = "schedule_version"
        case newProducers = "new_producers"
        case producerSignature = "producer_signature"
        case transactions, id
        case blockNum = "block_num"
        case refBlockPrefix = "ref_block_prefix"
    }
}


// MARK: - TransactionElement
struct TransactionElement: Codable {
    let status: String?
    let cpuUsageUs, netUsageWords: Int?
    let trx: TrxUnion?

    enum CodingKeys: String, CodingKey {
        case status
        case cpuUsageUs = "cpu_usage_us"
        case netUsageWords = "net_usage_words"
        case trx
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
    let packedContextFreeData: String?
    let contextFreeData: [String]?
    let packedTrx: String?
    let transaction: TrxTransaction?

    enum CodingKeys: String, CodingKey {
        case id, signatures, compression
        case packedContextFreeData = "packed_context_free_data"
        case contextFreeData = "context_free_data"
        case packedTrx = "packed_trx"
        case transaction
    }
}

// MARK: - TrxTransaction
struct TrxTransaction: Codable {
    let expiration: String?
    let refBlockNum, refBlockPrefix, maxNetUsageWords, maxCPUUsageMS: Int?
    let delaySEC: Int?
    let contextFreeActions: [String]?
    let actions: [Action]?

    enum CodingKeys: String, CodingKey {
        case expiration
        case refBlockNum = "ref_block_num"
        case refBlockPrefix = "ref_block_prefix"
        case maxNetUsageWords = "max_net_usage_words"
        case maxCPUUsageMS = "max_cpu_usage_ms"
        case delaySEC = "delay_sec"
        case contextFreeActions = "context_free_actions"
        case actions
    }
}

// MARK: - Action
struct Action: Codable {
    let account, name: String?
    let authorization: [Authorization]?
    let data: DataClass?
    let hexData: String?

    enum CodingKeys: String, CodingKey {
        case account, name, authorization, data
        case hexData = "hex_data"
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
