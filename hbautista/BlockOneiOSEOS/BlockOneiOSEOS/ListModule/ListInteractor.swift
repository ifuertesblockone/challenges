//
//  ListInteractor.swift
//  BlockOneiOSEOS
//
//  Created by Henry Bautista on 1/05/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import Foundation

extension ListPresenter {
    
    func getBlockChain(fromUrl: String) -> BlockChain? {
        let data = getData(urlString: fromUrl)!
        let blockChain = (try? JSONDecoder().decode(BlockChain.self, from: data))!
        return blockChain
    }

    func getBlock(fromUrl: String, blockId: String) -> Block? {
        let data = getData(urlString: fromUrl, param: blockId)!
        let block = (try? JSONDecoder().decode(Block.self, from: data))!
        self.jsonRawDict[block.id!] = ("RAW String: \(String(describing: String(data: data, encoding: .utf8)))")
        return block
    }

}
