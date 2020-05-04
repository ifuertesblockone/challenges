//
//  BlockTableViewCell.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 27/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import UIKit

class BlockTableViewCell: UITableViewCell {
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var blockNum: UILabel!
    
    static let identifier: String = "BlockTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        timestamp.text = nil
        blockNum.text = nil
    }
    
    func config(with viewModel: BlockListViewModel.BlockViewModel) {
        timestamp.text = String(format: "Timestamp: %@", viewModel.timestamp)
        blockNum.text = String(format: "Block Num: %@", viewModel.blockNum)
    }
}
