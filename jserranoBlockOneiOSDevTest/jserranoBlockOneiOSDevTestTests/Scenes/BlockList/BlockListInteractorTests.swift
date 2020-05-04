//
//  BlockListInteractorTests.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 28/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import XCTest
@testable import jserranoBlockOneiOSDevTest

final class BlockListInteractorTests: XCTestCase {
    typealias `Self` = BlockListInteractorTests
    
    struct MockError: Error {}
    
    var getBlockList: MockGetBlockList!
    var getBlockchainInfo: MockGetBlockchainInfo!
    var blockListPresenter: MockBlockListPresenter!
    
    var sut: BlockListInteractor!
    
    override func setUp() {
        super.setUp()
        getBlockList = MockGetBlockList()
        getBlockchainInfo = MockGetBlockchainInfo()
        blockListPresenter = MockBlockListPresenter()
        
        sut = BlockListInteractor(dependencies: BlockListInteractor.Dependencies(getBlockList: getBlockList,
                                                                                 getBlockchainInfo: getBlockchainInfo,
                                                                                 presenter: blockListPresenter))
    }
    
    override func tearDown() {
        sut = nil
        getBlockList = nil
        getBlockchainInfo = nil
        blockListPresenter = nil
    }
    
    func test_HandleSelectedCell_PresenterFormatsSelectedBlock() {
        // Given
        let mockSelectedBlockViewModel = BlockListViewModel.BlockViewModel(
            timestamp: "mock_timestamp",
            blockNum: "mock_blockNum",
            details: BlockListViewModel.BlockViewModel.BlockDetailViewModel(producer: "mock_producer",
                                                                            numberOfTransactions: 1,
                                                                            producerSignature: "mock_producerSignature",
                                                                            jsonResponse: nil))
        
        // When
        sut.handleSelectedCell(with: mockSelectedBlockViewModel)
        
        // Then
        XCTAssertEqual(sut.blockDetailViewModel,
                       mockSelectedBlockViewModel.details,
                       "The blockDetailViewModel method must be equal to mockSelectedBlockViewModel because this is the value for the viewModel")
    }
    
    func test_ThereAreABlockList_HandleTapShowBlockListButton_PresenterFormatsBlockList() {
        // Given
        let mockBlockList = [Block(timestamp: "mock_timestamp",
                                   producer: "mock_producer",
                                   previous: "mock_previous",
                                   producerSignature: "mock_producerSignature",
                                   transactions: [Block.Transaction(status: "mock_status",
                                                                    cpuUsageUs: 0,
                                                                    netUsageWords: 0)],
                                   id: "mock_id",
                                   blockNum: 0,
                                   rawJsonResponse: nil)]
        
        let mockBlockChainInfo = Blockchain(serverVersion: "mock_serverVersion",
                                            chainId: "mock_chainId",
                                            headBlockNum: 1,
                                            headBlockId: "mock_headBlockId",
                                            headBlockTime: "mock_headBlockTime",
                                            headBlockProducer: "mock_headBlockProducer",
                                            lastIrreversibleBlockNum: 0,
                                            lastIrreversibleBlockId: "mock_lastIrreversibleBlockId",
                                            virtualBlockCpuLimit: 0,
                                            virtualBlockNetLimit: 0,
                                            blockCpuLimit: 0,
                                            blockNetLimit: 0,
                                            serverVersionString: "mock_serverVersionString",
                                            forkDbHeadBlockNum: 0,
                                            forkBbHeadBlockId: "mock_forkBbHeadBlockId")
        
        getBlockchainInfo.mockExecute = .success(response: mockBlockChainInfo)
        getBlockList.mockExecute = .success(response: (mockBlockList, .completed))

        // When
        sut.handleTapShowBlockListButton()

        // Then        
        let (blockList, isCompleted) = blockListPresenter.getArgumentsForFormatBlockList()
        
        XCTAssertEqual(blockList.first??.id,
                       mockBlockList.first?.id,
                       "The blockList must be equal to mockBlockList because it was the value returned by the dependency")
        XCTAssertTrue(isCompleted, "isCompleted must be true because the blockListState is completed")
        XCTAssertEqual(blockListPresenter.formatBlockListInvocations(),
                       1,
                       "The formatBlockList method must be called because the process to get the block list was successful.")
    }
    
    func test_ThereIsAnErrorFromBlockchainInfoDependency_handleTapShowBlockListButton_InteractorCallsPresenterFormatErrorAlertMethod() {
        //Given
        getBlockchainInfo.mockExecute = .failure(error: MockError())
        
        //When
        sut.handleTapShowBlockListButton()
        
        //Then
        XCTAssertEqual(getBlockchainInfo.executeInvocations(),
        1,
        "The execute method must be called becuase this dependency is the first dependency that is called to retrieve the block list")
        XCTAssertEqual(blockListPresenter.formatErrorAlertInvocations(),
                       1,
                       "The formatErrorAlert must be called becuase there is an error from BlockchainInfo dependency")
    }
    
    func test_ThereIsAnErrorFromBlockListDependency_handleTapShowBlockListButton_InteractorCallsPresenterFormatErrorAlertMethod() {
        //Given
        let mockBlockChainInfo = Blockchain(serverVersion: "mock_serverVersion",
                                            chainId: "mock_chainId",
                                            headBlockNum: 1,
                                            headBlockId: "mock_headBlockId",
                                            headBlockTime: "mock_headBlockTime",
                                            headBlockProducer: "mock_headBlockProducer",
                                            lastIrreversibleBlockNum: 0,
                                            lastIrreversibleBlockId: "mock_lastIrreversibleBlockId",
                                            virtualBlockCpuLimit: 0,
                                            virtualBlockNetLimit: 0,
                                            blockCpuLimit: 0,
                                            blockNetLimit: 0,
                                            serverVersionString: "mock_serverVersionString",
                                            forkDbHeadBlockNum: 0,
                                            forkBbHeadBlockId: "mock_forkBbHeadBlockId")
        
        getBlockchainInfo.mockExecute = .success(response: mockBlockChainInfo)
        getBlockList.mockExecute = .failure(error: MockError())
        
        //When
        sut.handleTapShowBlockListButton()
        
        //Then
        XCTAssertEqual(getBlockchainInfo.executeInvocations(),
        1,
        "The execute method must be called becuase this dependency is the first dependency that is called to retrieve the block list")
        XCTAssertEqual(getBlockList.executeInvocations(),
                       1,
                       "The execute of getBlocList must be called because the blockchainInfo dependency response was successful")
        XCTAssertEqual(blockListPresenter.formatErrorAlertInvocations(),
                       1,
                       "The formatErrorAlert must be called becuase there is an error from BlockchainInfo dependency")
    }
}
