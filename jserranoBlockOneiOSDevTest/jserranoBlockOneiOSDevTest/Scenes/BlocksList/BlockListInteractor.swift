//
//  BlockListInteractor.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

protocol BlockListInteractorProtocol {
    func handleSceneDidLoad()
    func handleTapShowBlockListButton()
    func handleSelectedCell(with blockViewModel: BlockListViewModel.BlockViewModel)
}

final class BlockListInteractor: BlockListDataStore {
    struct Dependencies {
        var getBlockList: GetBlockList = GetBlockListAdapter()
        var getBlockchainInfo: GetBlockchainInfo = GetBlockchainInfoAdapter()
        var presenter: BlockListPresenterProtocol
    }
    
    let dependencies: Dependencies
    
    var blockDetailViewModel: BlockListViewModel.BlockViewModel.BlockDetailViewModel?
    var blockList: [Block?] = []
    var presenter: BlockListPresenterProtocol {
        return dependencies.presenter
    }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension BlockListInteractor.Dependencies {
    init(presenter: BlockListPresenterProtocol) {
        self.presenter = presenter
    }
}

extension BlockListInteractor: BlockListInteractorProtocol{
    func handleSceneDidLoad() {
    }
    
    func handleTapShowBlockListButton() {
        dependencies.getBlockchainInfo.execute { [weak self] (blockchainResponse) in
            switch blockchainResponse {
            case .success(let blockchainInfo):
                guard let blockID = blockchainInfo?.headBlockId else {
                    return
                }
                self?.handleBlockList(blockID: blockID)
            case .failure(let error):
                self?.presenter.formatErrorAlert(error)
            }
        }
    }
    
    func handleSelectedCell(with blockViewModel: BlockListViewModel.BlockViewModel) {
        blockDetailViewModel = blockViewModel.details
    }
}

private extension BlockListInteractor {
    func handleBlockList(blockID: String) {
        dependencies.getBlockList.execute(with: blockID) { [weak self] (blockListResponse) in
            switch blockListResponse {
            case .success(response: (let blockList, let blockListState)):
                print("Successful")
                print("\(blockList.count) blocks")
                switch blockListState {
                case .completed:
                    self?.presenter.formatBlockList(with: blockList, isCompleted: true)
                case .pending:
                    self?.presenter.formatBlockList(with: blockList)
                case .stopped:
                    self?.presenter.formatBlockListWithError(with: blockList)
                }
            case .failure(let error):
                self?.presenter.formatErrorAlert(error)
            }
        }
    }
}
