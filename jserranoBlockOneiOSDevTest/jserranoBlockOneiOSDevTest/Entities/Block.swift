//
//  Block.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

struct Block: Decodable {
    struct Transaction: Decodable{
        var status: String
        var cpuUsageUs: Int
        var netUsageWords: Int
        
        enum CodingKeys: String, CodingKey {
            case status
            case cpuUsageUs = "cpu_usage_us"
            case netUsageWords = "net_usage_words"
        }
    }
    
    var timestamp: String
    var producer: String
    var previous: String
    var producerSignature: String
    var transactions: [Transaction]
    var id: String
    var blockNum: Int
    var rawJsonResponse: AnyObject?
    
    enum CodingKeys: String, CodingKey {
        case timestamp
        case producer
        case previous
        case producerSignature = "producer_signature"
        case transactions
        case id
        case blockNum = "block_num"
    }
}
