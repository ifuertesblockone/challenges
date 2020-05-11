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
    func createBody(with paramaters: [String: Any]) -> Data?
    func makeRequest(with endpoint: String, method: HTTPMethod, data: Data?) -> URLRequest?
    func performTask(with request: URLRequest, completion: @escaping URLTaskCompletion)    
}

final class URLSessionAdapter: URLSessionProtocol {
    func makeRequest(with endpoint: String, method: HTTPMethod, data: Data?) -> URLRequest? {
        guard let url = URL(string: endpoint) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = data
        request.cachePolicy = .reloadIgnoringCacheData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func performTask(with request: URLRequest, completion: @escaping URLTaskCompletion) {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
    
    func createBody(with paramaters: [String: Any]) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: paramaters, options: .prettyPrinted)
        } catch {
            return nil
        }
    }
}
