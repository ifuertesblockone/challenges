//
//  URLSessionProtocol.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 24/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation

typealias URLTaskCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol URLSessionProtocol {
    func performTask(with request: URLRequest, completion: @escaping URLTaskCompletion)
}

final class URLSessionAdapter: URLSessionProtocol {
    func performTask(with request: URLRequest, completion: @escaping URLTaskCompletion) {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}
