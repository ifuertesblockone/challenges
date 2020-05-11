//
//  BlockListViewController.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import UIKit
import Foundation

protocol BlockListViewControllerProtocol: class {
    func updateView(with viewModel: BlockListViewModel, isCompleted: Bool)
    func displayErrorAlert(with viewModel: BlockListErrorViewModel)
}

class BlockListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    struct Constants {
           static let blockDetailSegue = "BlockDetail"
    }
    
    private var interactor: BlockListInteractorProtocol?
    var viewModel: BlockListViewModel?
    var router: (NSObjectProtocol & BlockListRouting & BlockListDataPassing)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        interactor?.handleSceneDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let scene = segue.identifier else {
            return
        }
        
        let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
        guard
            let router = router,
            router.responds(to: selector)
        else {
            return
        }
        
        router.perform(selector, with: segue)
    }
    
    @IBAction func didTaspBlockListButton(_ sender: Any) {
        displayLoadingAlert(title: "Loading blocks", message: "Please wait...")
        interactor?.handleTapShowBlockListButton()
    }
}

extension BlockListViewController: BlockListViewControllerProtocol {
    func displayErrorAlert(with viewModel: BlockListErrorViewModel) {
        displayAlert(title: viewModel.title,
                     message: viewModel.message,
                     acceptButtonText: viewModel.acceptButton,
                     completion: viewModel.acceptCompletion)
    }
    
    func updateView(with viewModel: BlockListViewModel, isCompleted: Bool) {
        self.viewModel = viewModel
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            
            guard isCompleted else {
                return
            }
            
            self?.dismiss(animated: true, completion: nil)
        }
    }
}

private extension BlockListViewController {
    func setup() {
        let presenter = BlockListPresenter(dependencies: .init(view: self))
        let interactor = BlockListInteractor(dependencies: .init(presenter: presenter))
        self.interactor = interactor
        let router = BlockListRouter()
        self.router = router
        router.viewController = self
        router.dataStore = interactor
        configTableView()
    }
    
    func configTableView() {
        registerCells()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func registerCells() {
        guard let tableView = tableView else {
            return
        }
        
        tableView.register(
            UINib.init(nibName: BlockTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: BlockTableViewCell.identifier)
    }
    
    func goToBlockDetailScreen() {
        performSegue(withIdentifier: Constants.blockDetailSegue, sender: self)
    }
}

extension BlockListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.blocks.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell(frame: .zero)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BlockTableViewCell.identifier, for: indexPath) as! BlockTableViewCell
        cell.selectionStyle = .none
        
        cell.config(with: viewModel.blocks[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        
        interactor?.handleSelectedCell(with: viewModel.blocks[indexPath.row])
        goToBlockDetailScreen()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.title
    }
}
