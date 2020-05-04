//
//  MockBlockDetailPresenter.swift
//  jserranoBlockOneiOSDevTestTests
//
//  Created by Jonathand Alberto Serrano Serrano on 28/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation
@testable import jserranoBlockOneiOSDevTest

final class MockBlockDetailPresenter: BlockDetailPresenterProtocol {
    struct MockError: Error {}
    
    private var formatBlockDetailInvocationsCounter = 0
    private var formatBlockDetailArguments: BlockListViewModel.BlockViewModel.BlockDetailViewModel?
    
    func formatBlockDetail(with viewModel: BlockListViewModel.BlockViewModel.BlockDetailViewModel) {
        formatBlockDetailArguments = viewModel
        formatBlockDetailInvocationsCounter += 1
    }
    
    func getFormatBlockDetailArguments() -> BlockListViewModel.BlockViewModel.BlockDetailViewModel? {
        return formatBlockDetailArguments
    }
    
    func getFormatBlockDetailInvocationsCounter() -> Int {
        return formatBlockDetailInvocationsCounter
    }
}
