//
//  ListInteractor.swift
//  BlockOneiOSEOS
//
//  Created by Henry Bautista on 28/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import SwiftUI

public class BlockChainFetcher: ObservableObject {
    @Published var blockChains = [BlockChain]()
    @Published var blocks = [Block]()
    @Published var jsonRaws = [String]()
    private let server = "eos.greymass.com"
    private let port = "443"
    private let api = "/v1/chain"
    private var chainInfoUrlString = ""
    private var blockInfoUrlString = ""
    private var previousBlockId = ""
    private var pendingBlocks = 20
    
    init(){
        self.chainInfoUrlString = "https://\(server):\(port)\(api)/get_info"
        self.blockInfoUrlString = "https://\(server):\(port)\(api)/get_block"
        self.loadBlockChainData()

    }
    
    func loadBlockChainData() {
        print(chainInfoUrlString)
        guard let url = URL(string: chainInfoUrlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else{
                print("in process")
                guard let blockChainJSON = data else {
                    return
                }
                do {
                    let blockChain = try JSONDecoder().decode(BlockChain.self, from: blockChainJSON)
                    guard let lastHeadBlockId = blockChain.head_block_id else {
                        return
                    }
                    print (lastHeadBlockId)
                    DispatchQueue.main.async {
                        self.previousBlockId = lastHeadBlockId
                        self.loadBlockData()
                    }
                    print("returning")
                } catch let jsonErr {
                    print("Error Serializing Json from \(self.chainInfoUrlString): ", jsonErr)
                }
            }
        }.resume()
    }
    
    
    func loadBlockData() {
        if self.pendingBlocks < 1 {
            return
        } else {
            guard let url = URL(string: blockInfoUrlString) else {
                return
            }
            let json: [String: Any] = ["block_num_or_id": previousBlockId]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                else{
                    print("in process")
                    guard let blockJSON = data else { return }
                    let jsonString = ("JSON String: \(String(describing: String(data: blockJSON, encoding: .utf8)))")
                    do {
                        let block = try JSONDecoder().decode(Block.self, from: blockJSON)
                        DispatchQueue.main.async {
                            self.blocks.append(block)
                            self.jsonRaws.append(jsonString)
                            self.previousBlockId = block.previous
                            self.pendingBlocks -= 1
                            print(self.previousBlockId)
                            print(self.pendingBlocks)
                            self.loadBlockData()
                        }
                        print(block.id)
                    } catch let jsonErr {
                        print("Error Serializing Json from \(self.blockInfoUrlString): ", jsonErr)
                    }
                }
            }.resume()
        }
    }
}
