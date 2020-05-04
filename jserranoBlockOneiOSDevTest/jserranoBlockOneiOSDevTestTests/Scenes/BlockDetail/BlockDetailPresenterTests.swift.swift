//
//  BlockDetailPresenterTests.swift.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 28/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import XCTest
@testable import jserranoBlockOneiOSDevTest

final class BlockDetailPresenterTests: XCTestCase {
    typealias `Self` = BlockDetailPresenterTests
    
    var blockDetailView: MockBlockDetailView!
    
    var sut: BlockDetailPresenter!
    
    override func setUp() {
        super.setUp()
        blockDetailView = MockBlockDetailView()
        
        sut = BlockDetailPresenter(dependencies: .init(view: blockDetailView))
    }
    
    override func tearDown() {
        sut = nil
        blockDetailView = nil
    }
    
    func test_ThereIsACompletedBlockList_FormatBlockList_PresenterCallsViewToUpdateIt() {
        // Given
        let mockViewModel = BlockListViewModel.BlockViewModel.BlockDetailViewModel(producer: "mock_producer",
                                                                                   numberOfTransactions: 0,
                                                                                   producerSignature: "mock_producerSignature",
                                                                                   jsonResponse: nil)
        
        // When
        sut.formatBlockDetail(with: mockViewModel)
        
        // Then
        guard let viewmodel = blockDetailView.getUpdateViewArguments() else {
            XCTFail("The presenter must send the viewModel to view to update it")
            return
        }
        
        XCTAssertEqual(blockDetailView.updateViewInvocations(),
                       1,
                       "The updateView method must be called because it is the method used to update the view")
        XCTAssertEqual(viewmodel,
                       mockViewModel,
                       "The viewModel sent to the view must be equal to expectedViewModel, because it was created with the blockList")
    }
}
