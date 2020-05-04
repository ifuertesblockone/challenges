//
//  BlockchainError.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation


public enum BlockchainError: Error {
    case invalidInformation
    case serviceError
    case unknownServiceError
    case unknownError
    case customError(description: String)
}

extension BlockchainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidInformation:
            return NSLocalizedString("The values to get the block are invalid", comment: "BlockchainError")
        case .serviceError:
            return NSLocalizedString("There was an service error", comment: "BlockchainError")
        case .unknownServiceError:
            return NSLocalizedString("There was an unknown service error", comment: "BlockchainError")
        case .unknownError:
            return NSLocalizedString("There was an unkown error", comment: "BlockchainError")
        case .customError(let description):
            return NSLocalizedString(description, comment: "BlockchainError")
        }
    }
}
