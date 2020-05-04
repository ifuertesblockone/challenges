//
//  ServiceResponse.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

enum ServiceResponse<T> {
    case success(response: T)
    case failure(error: Error)
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}
