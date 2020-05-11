//
//  BlockListPresenterTests.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 28/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import XCTest
@testable import jserranoBlockOneiOSDevTest

final class BlockListPresenterTests: XCTestCase {
    typealias `Self` = BlockListPresenterTests
    
    struct MockError: Error {}
    static let mockBlockList = [Block(timestamp: "mock_timestamp",
                                      producer: "mock_producer",
                                      previous: "mock_previous",
                                      producerSignature: "mock_producerSignature",
                                      transactions: [Block.Transaction(status: "mock_status",
                                                                       cpuUsageUs: 0,
                                                                       netUsageWords: 0)],
                                      id: "mock_id",
                                      blockNum: 0,
                                      rawJsonResponse: nil)]
    
    static let mockBlockListErrorViewModel = BlockListErrorViewModel(title: "Block list error",
                                                                     message: "There was an error with the block download process.",
                                                                     acceptButton: "Accept",
                                                                     acceptCompletion: nil)
    
    var blockListView: MockBlockListView!
    
    var sut: BlockListPresenter!
    
    override func setUp() {
        super.setUp()
        blockListView = MockBlockListView()
        
        sut = BlockListPresenter(dependencies: BlockListPresenter.Dependencies(view: blockListView))
    }
    
    override func tearDown() {
        sut = nil
        blockListView = nil
    }
    
    func test_ThereIsACompletedBlockList_FormatBlockList_PresenterCallsViewToUpdateIt() {
        // Given
        let expectedViewModel = createBlockListViewModel(with: Self.mockBlockList)
        
        // When
        sut.formatBlockList(with: Self.mockBlockList, isCompleted: true)
        
        // Then
        guard let(viewmodel, isCompleted) = blockListView.getUpdateViewArguments() else {
            XCTFail("The presenter must send the viewModel and isCompleted parameters to view to update it")
            return
        }
        
        XCTAssertEqual(blockListView.updateViewInvocations(), 1, "The updateView method must be called because it is the method used to update the view")
        XCTAssertTrue(isCompleted, "isCompleted must be true because the blockList is completed")
        XCTAssertEqual(viewmodel, expectedViewModel, "The viewModel sent to the view must be equal to expectedViewModel, because it was created with the blockList")
    }
    
    func test_ThereAreParcialBlockList_FormatBlockList_PresenterCallsViewToUpdateIt() {
        // Given
        let expectedViewModel = createBlockListViewModel(with: Self.mockBlockList)
        
        // When
        sut.formatBlockList(with: Self.mockBlockList)
        
        // Then
        guard let(viewmodel, isCompleted) = blockListView.getUpdateViewArguments() else {
            XCTFail("The presenter must send the viewModel and isCompleted parameters to view to update it")
            return
        }
        
        XCTAssertEqual(blockListView.updateViewInvocations(), 1, "The updateView method must be called because it is the method used to update the view")
        XCTAssertFalse(isCompleted, "isCompleted must be false because the blockList is not completed")
        XCTAssertEqual(viewmodel, expectedViewModel, "The viewModel sent to the view must be equal to expectedViewModel, because it was created with the blockList")
    }
    
    func test_ThereIsAnError_FormatBlockListWithError_PresenterCallsUpdateViewAndDisplaysErrorAlert() {
        // Given
        let expectedViewModel = createBlockListViewModel(with: Self.mockBlockList)
        
        // When
        sut.formatBlockListWithError(with: Self.mockBlockList)
        
        // Then
        guard let(viewmodel, isCompleted) = blockListView.getUpdateViewArguments() else {
            XCTFail("The presenter must send the viewModel and isCompleted parameters to view to update it")
            return
        }
        
        guard let blockListErrorViewModel = blockListView.getdisplayErrorAlertArguments() else {
            XCTFail("The blockListErrorViewModel must be valid because there was an error retrieving the blockList")
            return
        }
        
        XCTAssertEqual(blockListView.updateViewInvocations(), 1, "The updateView method must be called because it is the method used to update the view")
        XCTAssertTrue(isCompleted, "isCompleted must be true because the blockList is completed")
        XCTAssertEqual(viewmodel, expectedViewModel, "The viewModel sent to the view must be equal to expectedViewModel, because it was created with the blockList")
        XCTAssertEqual(blockListErrorViewModel,
                       Self.mockBlockListErrorViewModel,
                       "The blockListErrorViewModel sent to the view must be equal to expectedBlockListErrorViewModel, because there was an error retrieving the blockList")
    }
    
    func test_FormatErrorAlert_PresenterCallsViewDisplayErrorAlertMethod() {
        // When
        sut.formatErrorAlert(MockError())
        
        // Then
        XCTAssertEqual(blockListView.displayErrorAlertInvocations(),
                       1,
                       "The displayErrorAlert method must be called because there is an error to display")
    }
}

private extension BlockListPresenterTests {
    func createBlockListViewModel(with blockList: [Block?]) -> BlockListViewModel {
        return BlockListViewModel(title: "Latest Blocks",
                                  blocks: blockList.compactMap { createBlockViewModel(with: $0) })
        
    }
    
    func createBlockViewModel(with block: Block?) -> BlockListViewModel.BlockViewModel? {
        guard let block = block else {
            return nil
        }
        
        return BlockListViewModel.BlockViewModel(
            timestamp: block.timestamp,
            blockNum: String(format: "%d", block.blockNum),
            details: BlockListViewModel.BlockViewModel.BlockDetailViewModel(
                producer: block.producer,
                numberOfTransactions: block.transactions.count,
                producerSignature: block.producerSignature,
                jsonResponse: block.rawJsonResponse?.description))
    }
}
