//
//  BlockchainService.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

typealias BlockchainInfoResponse = (ServiceResponse<Blockchain?>) -> Void

protocol BlockchainService {
    func getInfo(completion: @escaping BlockchainInfoResponse)
}
