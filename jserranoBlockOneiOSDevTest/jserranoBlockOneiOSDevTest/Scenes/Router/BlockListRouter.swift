//
//  BlockListRouter.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 29/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import UIKit

protocol BlockListDataStore {
    var blockDetailViewModel: BlockListViewModel.BlockViewModel.BlockDetailViewModel? { get }
}

@objc protocol BlockListRouting {
    func routeToBlockDetail(segue: UIStoryboardSegue?)
}

protocol BlockListDataPassing {
    var dataStore: BlockListDataStore? { get }
}

final class BlockListRouter: NSObject, BlockListRouting, BlockListDataPassing {
    weak var viewController: BlockListViewController?
    var dataStore: BlockListDataStore?
    
    func routeToBlockDetail(segue: UIStoryboardSegue?) {
        guard let segue = segue else {
            routeToBlockDetailFromStoryboard()
            return
        }
        
        routeToBlockDetailFromSegue(segue: segue)
    }
}

private extension BlockListRouter {
    func routeToBlockDetailFromSegue(segue: UIStoryboardSegue) {
        guard
            let destinationVC = segue.destination as? BlockDetailViewController,
            var destinationDS = destinationVC.router?.dataStore,
            let dataStore = dataStore
        else {
            return
        }
        
        passDataToBlockDetail(source: dataStore, destination: &destinationDS)
    }
    
    func routeToBlockDetailFromStoryboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let destinationVC = storyboard.instantiateViewController(identifier: "BlockDetailViewController") as? BlockDetailViewController,
            var destinationDS = destinationVC.router?.dataStore,
            let dataStore = dataStore
        else {
            return
        }
        
        passDataToBlockDetail(source: dataStore, destination: &destinationDS)
        navigateToBlockDetail(source: viewController!, destination: destinationVC)
    }
    
    func passDataToBlockDetail(source: BlockListDataStore, destination: inout BlockDetailDataStore) {
        destination.viewModel = source.blockDetailViewModel
    }
    
    func navigateToBlockDetail(source: BlockListViewController, destination: BlockDetailViewController) {
        source.show(destination, sender: nil)
    }
}
