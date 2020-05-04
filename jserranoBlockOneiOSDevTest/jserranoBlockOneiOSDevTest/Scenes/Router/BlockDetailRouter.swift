//
//  BlockDetailRouter.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 29/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

protocol BlockDetailDataPassing {
    var dataStore: BlockDetailDataStore? { get }
}

protocol BlockDetailDataStore {
    var viewModel: BlockListViewModel.BlockViewModel.BlockDetailViewModel? { set get }
}

final class BlockDetailRouter: NSObject, BlockDetailDataPassing {
    weak var viewController: BlockDetailViewController?
    var dataStore: BlockDetailDataStore?
}
