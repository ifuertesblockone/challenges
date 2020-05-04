//
//  BlockService.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

typealias BlockResponse = (ServiceResponse<[Block?]>) -> Void

protocol BlockService  {
    func getBlock(blockID: String, completion: @escaping BlockResponse)
}
