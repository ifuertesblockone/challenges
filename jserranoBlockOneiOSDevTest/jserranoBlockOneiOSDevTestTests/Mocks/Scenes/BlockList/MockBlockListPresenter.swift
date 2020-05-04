//
//  MockBlockListPresenter.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 28/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation
@testable import jserranoBlockOneiOSDevTest

final class MockBlockListPresenter: BlockListPresenterProtocol {
    struct MockError: Error {}
    
    private var formatBlockListInvocationsCounter = 0
    private var formatSelectedBlockInvocationsCounter = 0
    private var formatBlockListWithErrorInvocationsCounter = 0
    private var formatErrorAlertInvocationsCounter = 0
    
    private var argumentsForFormatBlockList: ([Block?], Bool) = ([], false)
    
    func formatBlockList(with blockList: [Block?], isCompleted: Bool) {
        formatBlockListInvocationsCounter += 1
        argumentsForFormatBlockList = (blockList, isCompleted)
    }
    
    func formatSelectedBlock(with viewModel: BlockListViewModel.BlockViewModel) {
        formatSelectedBlockInvocationsCounter += 1
    }
    
    func formatBlockListWithError(with blockList: [Block?]) {
        formatBlockListWithErrorInvocationsCounter += 1
    }
    
    func formatErrorAlert(_ error: Error) {
        formatErrorAlertInvocationsCounter += 1
    }
    
    func formatBlockListInvocations() -> Int {
        return formatBlockListInvocationsCounter
    }
    
    func formatSelectedBlockInvocations() -> Int {
        return formatSelectedBlockInvocationsCounter
    }
    
    func formatBlockListWithErrorInvocations() -> Int {
        return formatBlockListWithErrorInvocationsCounter
    }
    
    func formatErrorAlertInvocations() -> Int {
        return formatErrorAlertInvocationsCounter
    }
    
    func getArgumentsForFormatBlockList() -> ([Block?], Bool) {
        return argumentsForFormatBlockList
    }
}
