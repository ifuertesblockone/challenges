//
//  GetBlockList.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

enum BlockListState {
    case completed
    case pending
    case stopped
}

typealias BlockListResponse = (ServiceResponse<([Block?], BlockListState)>) -> Void

protocol GetBlockList {
    func execute(with blockID: String, completion: @escaping BlockListResponse)
}
