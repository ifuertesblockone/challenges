//
//  MockBlockDetailView.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 28/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation
@testable import jserranoBlockOneiOSDevTest

final class MockBlockDetailView: BlockDetailViewProtocol {
    struct MockError: Error {}
    
    private var updateViewInvocationsCounter = 0
    private var updateViewArguments: BlockListViewModel.BlockViewModel.BlockDetailViewModel?
    
    func updateView(with viewModel: BlockListViewModel.BlockViewModel.BlockDetailViewModel) {
        updateViewArguments = viewModel
        updateViewInvocationsCounter += 1
    }
    
    func getUpdateViewArguments() -> BlockListViewModel.BlockViewModel.BlockDetailViewModel? {
        return updateViewArguments
    }
    
    func updateViewInvocations() -> Int {
        return updateViewInvocationsCounter
    }
}
