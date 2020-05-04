//
//  GetBlockchainInfo.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 27/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

protocol GetBlockchainInfo {
    func execute(completion: @escaping BlockchainInfoResponse)
}
