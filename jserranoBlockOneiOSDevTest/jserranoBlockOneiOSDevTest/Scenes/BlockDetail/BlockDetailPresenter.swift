//
//  BlockDetailPresenter.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 27/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

protocol BlockDetailPresenterProtocol {
    func formatBlockDetail(with viewModel: BlockListViewModel.BlockViewModel.BlockDetailViewModel)
}

final class BlockDetailPresenter {
    struct Dependencies {
        weak var view: BlockDetailViewProtocol?
    }
    
    let dependencies: Dependencies
    var view: BlockDetailViewProtocol? {
        return dependencies.view
    }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension BlockDetailPresenter: BlockDetailPresenterProtocol {
    func formatBlockDetail(with viewModel: BlockListViewModel.BlockViewModel.BlockDetailViewModel) {
        view?.updateView(with: viewModel)
    }
}
