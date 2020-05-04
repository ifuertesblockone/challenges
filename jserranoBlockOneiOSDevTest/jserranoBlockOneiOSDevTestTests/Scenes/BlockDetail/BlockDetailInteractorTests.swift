//
//  BlockDetailInteractorTests.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 28/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import XCTest
@testable import jserranoBlockOneiOSDevTest

final class BlockDetailInteractorTests: XCTestCase {
    typealias `Self` = BlockDetailInteractorTests
    
    struct MockError: Error {}
    
    var blockDetailPresenter: MockBlockDetailPresenter!
    
    var sut: BlockDetailInteractor!
    
    override func setUp() {
        super.setUp()
        blockDetailPresenter = MockBlockDetailPresenter()
        
        sut = BlockDetailInteractor(dependencies: .init(presenter: blockDetailPresenter))
    }
    
    override func tearDown() {
        sut = nil
        blockDetailPresenter = nil
    }
    
    func test_ThereIsViewModel_HandleSceneDidLoad_InteractorCallsFormatBlockDetail() {
        // Given
        let mockViewModel = BlockListViewModel.BlockViewModel.BlockDetailViewModel(producer: "mock_producer",
                                                                                   numberOfTransactions: 0,
                                                                                   producerSignature: "mock_producerSignature",
                                                                                   jsonResponse: nil)
        sut.viewModel = mockViewModel
        
        // When
        sut.handleSceneDidLoad()
        
        // Then
        guard let viewModel = blockDetailPresenter.getFormatBlockDetailArguments() else {
            XCTFail("The viewModel must be valid because it is the viewModel of sut")
            return
        }
        
        XCTAssertEqual(blockDetailPresenter.getFormatBlockDetailInvocationsCounter(),
                       1,
                       "The formatBlockDetail must be called because there is a viewModel valid")
        XCTAssertEqual(viewModel,
                       mockViewModel,
                       "The viewModel must be equal to mockViewModel because it is the viewModel that was passed to presenter method")
    }
    
    func test_ThereIsNoViewModel_HandleSceneDidLoad_InteractorDoesNotCallFormatBlockDetail() {
        // Given
        sut.viewModel = nil
        
        // When
        sut.handleSceneDidLoad()
        
        // Then
        XCTAssertEqual(blockDetailPresenter.getFormatBlockDetailInvocationsCounter(),
                       0,
                       "The formatBlockDetail must not be called because there is no a viewModel valid")
    }
}
