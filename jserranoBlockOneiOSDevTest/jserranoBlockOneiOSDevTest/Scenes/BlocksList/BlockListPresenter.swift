//
//  BlockListPresenter.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

protocol BlockListPresenterProtocol {
    func formatBlockList(with blockList: [Block?], isCompleted: Bool)
    func formatBlockListWithError(with blockList: [Block?])
    func formatErrorAlert(_ error: Error)
}

extension BlockListPresenterProtocol {
    func formatBlockList(with blockList: [Block?]) {
        formatBlockList(with: blockList, isCompleted: false)
    }
}

final class BlockListPresenter {
    struct Constants {
        static let blockListErrorMessage = "There was an error with the block download process."
        static let blockListErrorTitle = "Block list error"
        static let blockListErrorAcceptButton = "Accept"
    }
    
    struct Dependencies {
        weak var view: BlockListViewControllerProtocol?
    }
    
    let dependencies: Dependencies
    var view: BlockListViewControllerProtocol? {
        return dependencies.view
    }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }    
}

extension BlockListPresenter: BlockListPresenterProtocol{
    func formatErrorAlert(_ error: Error) {
        view?.displayErrorAlert(with: BlockListErrorViewModel(title: Constants.blockListErrorTitle,
                                                              message: error.localizedDescription,
                                                              acceptButton: Constants.blockListErrorAcceptButton,
                                                              acceptCompletion: nil))
    }
    
    func formatBlockListWithError(with blockList: [Block?]) {
        view?.updateView(with: createViewModel(with: blockList), isCompleted: true)
        view?.displayErrorAlert(with: BlockListErrorViewModel(title: Constants.blockListErrorTitle,
                                                              message: Constants.blockListErrorMessage,
                                                              acceptButton: Constants.blockListErrorAcceptButton,
                                                              acceptCompletion: nil))
    }
    
    func formatBlockList(with blockList: [Block?], isCompleted: Bool = false) {
        view?.updateView(with: createViewModel(with: blockList), isCompleted: isCompleted)
    }
}

private extension BlockListPresenter {
    func createViewModel(with blockList: [Block?]) -> BlockListViewModel {
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
                jsonResponse: block.rawJsonResponse))
    }
}
