//
//  BlockOneiOSEOSTests.swift
//  BlockOneiOSEOSTests
//
//  Created by Henry Bautista on 27/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import XCTest
@testable import BlockOneiOSEOS

class BlockOneiOSEOSTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
                _ = ListPresenter()
        }
    }
    
    func test_BlockOneiOSEOS_ListInteractor_getData_without_param() {
        // GIVEN
        let url = "https://eos.greymass.com:443/v1/chain/get_info"
        let interactor = ListPresenter()
        let getData = interactor.getData(urlString: url)!
           
        // WHEN
        
        let param = ""
        var result: Data!
        let semaphore = DispatchSemaphore(value: 0)
        let session = URLSession.shared
        var jsonData: Data?
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let json: [String: Any] = ["block_num_or_id": param]
        jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            result = data
            semaphore.signal()
        }).resume()
        semaphore.wait()
        
        // THEN
        XCTAssertEqual(!result.isEmpty, !getData.isEmpty, "Primary Chain request must contain data!")
    }
    
    func test_BlockOneiOSEOS_ListInteractor_getData_with_param() {
        // GIVEN
        let url = "https://eos.greymass.com:443/v1/chain/get_block"
        let param = "070a9be68a548a6542cc9244c2efd5aeaeb077314dc8a54b3c753af1c15df0ec"
        let interactor = ListPresenter()
        let getData = interactor.getData(urlString: url, param: param)!
           
        // WHEN result true
        var result: Data!
        let semaphore = DispatchSemaphore(value: 0)
        let session = URLSession.shared
        var jsonData: Data?
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let json: [String: Any] = ["block_num_or_id": param]
        jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            result = data
            semaphore.signal()
        }).resume()
        semaphore.wait()
           
        // THEN
        XCTAssertEqual(!result.isEmpty, !getData.isEmpty, "Primary Block request must contain data!")
    }
    
    func test_BlockOneiOSEOS_ListInteractor_getBlockChain() {
        // GIVEN
        let urlString = "https://eos.greymass.com:443/v1/chain/get_info"
        let interactor = ListPresenter()
        let chainResult = interactor.getBlockChain(fromUrl: urlString)
        
        // WHEN result true
        let data = interactor.getData(urlString: "https://eos.greymass.com:443/v1/chain/get_info")!
        let blockChain = (try? JSONDecoder().decode(BlockChain.self, from: data))!
        
        // THEN
        XCTAssertEqual(chainResult?.chainID!,blockChain.chainID!, "Function getBlockChain must return \(String(describing: blockChain.chainID!)).")
    }
    
    func test_BlockOneiOSEOS_ListInteractor_getBlock() {
        // GIVEN
        let urlString = "https://eos.greymass.com:443/v1/chain/get_block"
        let blockId = "070a9be68a548a6542cc9244c2efd5aeaeb077314dc8a54b3c753af1c15df0ec"
        let interactor = ListPresenter()
        let blockResult = interactor.getBlock(fromUrl: urlString, blockId: blockId)
           
        // WHEN
        let data = interactor.getData(urlString: urlString, param: blockId)!
        let block = (try? JSONDecoder().decode(Block.self, from: data))!
           
        // THEN
        XCTAssertEqual(blockResult?.id!, block.id, "Function getBlockChain must return \(String(describing: block.id!)).")
    }
    
    func test_BlockOneiOSEOS_BlockChainFetcher_loadBlockChainData() {
        // GIVEN
       
        
        // WHEN result true
        let urlString = "https://eos.greymass.com:443/v1/chain/get_info"
        let interactor = ListPresenter()
        let chain_id = interactor.getBlockChain(fromUrl: urlString)?.chainID!
        
        // THEN
        XCTAssert(!chain_id!.isEmpty, "BlockChains must have a value.")
    }
    
    func test_BlockOneiOSEOS_BlockChainFetcher_loadBlockData() {
        // GIVEN
       
        
        // WHEN result true
        let urlString = "https://eos.greymass.com:443/v1/chain/get_block"
        let blockId = "070a9be68a548a6542cc9244c2efd5aeaeb077314dc8a54b3c753af1c15df0ec"
        let interactor = ListPresenter()
        let id = interactor.getBlock(fromUrl: urlString, blockId: blockId)?.id!
        

        // THEN
        XCTAssert(!id!.isEmpty, "Block must have a value.")
    }
}
