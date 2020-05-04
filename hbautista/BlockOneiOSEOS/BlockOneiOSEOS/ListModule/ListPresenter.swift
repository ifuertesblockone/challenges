//
//  ListInteractor.swift
//  BlockOneiOSEOS
//
//  Created by Henry Bautista on 28/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import Foundation

public class ListPresenter: ObservableObject {
    @Published var blockChains = [BlockChain]()
    @Published var blocks = [Block]()
    @Published var jsonRawDict: [String: String]
    private let server = "eos.greymass.com"
    private let port = "443"
    private let api = "/v1/chain"
    private var chainInfoUrlString = ""
    private var blockInfoUrlString = ""
    private var previousBlockID = ""
    private var pendingBlocks = 20
    
    init(){
        self.chainInfoUrlString = "https://\(server):\(port)\(api)/get_info"
        self.blockInfoUrlString = "https://\(server):\(port)\(api)/get_block"
        self.jsonRawDict = [:]
        self.loadBlockChainData()
    }
    
    func loadBlockChainData() {
        DispatchQueue.main.async {
            let blockChain = self.getBlockChain(fromUrl: self.chainInfoUrlString)
            guard let lastHeadBlockID = blockChain?.headBlockID else {
                return
            }
            self.blockChains.append(blockChain!)
            self.previousBlockID = lastHeadBlockID
            self.loadBlockData()
        }
    }
    
    func loadBlockData() {
        if self.pendingBlocks < 1 {
            return
        } else {
            let block = self.getBlock(fromUrl: self.blockInfoUrlString, blockId: self.previousBlockID)
            DispatchQueue.main.async {
                self.blocks.append(block!)
                self.previousBlockID = block!.previous!
                self.pendingBlocks -= 1
                self.loadBlockData()
            }
        }
    }
}
