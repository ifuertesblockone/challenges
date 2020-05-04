//
//  BlockDetailViewController.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 27/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import UIKit

protocol BlockDetailViewProtocol: class {
    func updateView(with viewModel: BlockListViewModel.BlockViewModel.BlockDetailViewModel)
}

final class BlockDetailViewController: UIViewController {
    @IBOutlet weak var blockContentTextView: UITextView!
    @IBOutlet weak var producerSignatureLabel: UILabel!
    @IBOutlet weak var numberOfTransactionsLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    
    var interactor: BlockDetailInteractorProtocol?
    var router: (NSObjectProtocol & BlockDetailDataPassing)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.handleSceneDidLoad()
    }
    
    @IBAction func didChangeBlockContentVisibility(_ sender: Any) {
        blockContentTextView.toggleVisibility()
    }
}

extension BlockDetailViewController: BlockDetailViewProtocol {
    func updateView(with viewModel: BlockListViewModel.BlockViewModel.BlockDetailViewModel) {
        producerLabel.text = String(format: "Producer: %@", viewModel.producer)
        producerSignatureLabel.text = String(format: "Producer signature: %@", viewModel.producerSignature)
        numberOfTransactionsLabel.text = String(format: "Number of transactions: %d", viewModel.numberOfTransactions)
        blockContentTextView.text = viewModel.jsonResponse?.description
    }
}

private extension BlockDetailViewController {
    func setup() {
        let presenter = BlockDetailPresenter(dependencies: .init(view: self))
        let interactor = BlockDetailInteractor(dependencies: .init(presenter: presenter))
        self.interactor = interactor
        let router = BlockDetailRouter()
        self.router = router
        router.viewController = self
        router.dataStore = interactor
    }
}

private extension UITextView {
    func toggleVisibility() {
        self.isHidden = !self.isHidden
    }
}
