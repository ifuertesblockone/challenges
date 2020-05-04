//
//  MockBlockListView.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 28/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation
@testable import jserranoBlockOneiOSDevTest

final class MockBlockListView: BlockListViewControllerProtocol {
    struct MockError: Error {}
    
    private var updateViewInvocationsCounter = 0
    private var goToBlockDetailScreenInvocationsCounter = 0
    private var displayErrorAlertInvocationsCounter = 0
    
    private var updateViewArguments: (BlockListViewModel, Bool)?
    private var goToBlockDetailScreenArguments: BlockListViewModel.BlockViewModel.BlockDetailViewModel?
    private var displayErrorAlertArguments: BlockListErrorViewModel?
    
    func updateView(with viewModel: BlockListViewModel, isCompleted: Bool) {
        updateViewArguments = (viewModel, isCompleted)
        updateViewInvocationsCounter += 1
    }
    
    func goToBlockDetailScreen(with viewModel: BlockListViewModel.BlockViewModel.BlockDetailViewModel) {
        goToBlockDetailScreenArguments = viewModel
        goToBlockDetailScreenInvocationsCounter += 1
    }
    
    func displayErrorAlert(with viewModel: BlockListErrorViewModel) {
        displayErrorAlertArguments = viewModel
        displayErrorAlertInvocationsCounter += 1
    }
    
    func updateViewInvocations() -> Int {
        return updateViewInvocationsCounter
    }
    
    func goToBlockDetailScreenInvocations() -> Int {
        return goToBlockDetailScreenInvocationsCounter
    }
    
    func displayErrorAlertInvocations() -> Int {
        return displayErrorAlertInvocationsCounter
    }
    
    func getUpdateViewArguments() -> (BlockListViewModel, Bool)? {
        return updateViewArguments
    }
    
    func getGoToBlockDetailScreenArguments() -> BlockListViewModel.BlockViewModel.BlockDetailViewModel? {
        return goToBlockDetailScreenArguments
    }
    
    func getdisplayErrorAlertArguments() -> BlockListErrorViewModel? {
        return displayErrorAlertArguments
    }
}
