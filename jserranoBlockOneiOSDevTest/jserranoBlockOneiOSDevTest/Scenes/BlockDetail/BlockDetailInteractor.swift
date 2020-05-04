//
//  BlockDetailInteractor.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 27/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

import Foundation

protocol BlockDetailInteractorProtocol {
    func handleSceneDidLoad()
}

final class BlockDetailInteractor: BlockDetailDataStore {
    struct Dependencies {
        var presenter: BlockDetailPresenterProtocol
    }
    
    let dependencies: Dependencies
    
    var viewModel: BlockListViewModel.BlockViewModel.BlockDetailViewModel?
    
    var presenter: BlockDetailPresenterProtocol {
        return dependencies.presenter
    }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension BlockDetailInteractor: BlockDetailInteractorProtocol {
    func handleSceneDidLoad() {
        guard let viewModel = viewModel else {
            return
        }
        
        presenter.formatBlockDetail(with: viewModel)
    }
}
