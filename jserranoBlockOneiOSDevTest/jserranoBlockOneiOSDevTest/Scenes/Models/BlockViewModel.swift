//
//  BlockViewModel.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 27/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

struct BlockListViewModel: Equatable {
    struct BlockViewModel: Equatable {
        struct BlockDetailViewModel: Equatable {
            var producer: String
            var numberOfTransactions: Int
            var producerSignature: String
            var jsonResponse: AnyObject?
        }
        
        var timestamp: String
        var blockNum: String
        var details: BlockDetailViewModel
    }
    
    var title: String
    var blocks: [BlockViewModel]
}

extension BlockListViewModel.BlockViewModel.BlockDetailViewModel {
    static func == (lhs: BlockListViewModel.BlockViewModel.BlockDetailViewModel, rhs: BlockListViewModel.BlockViewModel.BlockDetailViewModel) -> Bool {
        return lhs.producer == rhs.producer &&
            lhs.numberOfTransactions == rhs.numberOfTransactions &&
            lhs.producerSignature == rhs.producerSignature
    }
}

struct BlockListErrorViewModel: Equatable {
    var title: String
    var message: String
    var acceptButton: String
    var acceptCompletion: (() -> Void)?
}

extension BlockListErrorViewModel {
    static func == (lhs: BlockListErrorViewModel, rhs: BlockListErrorViewModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.message == rhs.message &&
            lhs.acceptButton == rhs.acceptButton
    }
}
