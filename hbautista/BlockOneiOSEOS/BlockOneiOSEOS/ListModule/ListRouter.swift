//
//  ListRouter.swift
//  BlockOneiOSEOS
//
//  Created by Henry Bautista on 30/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//
import Foundation

extension ListPresenter {

    func getData(urlString: String, param: String? = nil) -> Data? {
        if let url = URL(string: urlString) {
            var result: Data!
            let semaphore = DispatchSemaphore(value: 0)
            let session = URLSession.shared
            var jsonData: Data?
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            if param != nil {
                let json: [String: Any] = ["block_num_or_id": param!]
                jsonData = try? JSONSerialization.data(withJSONObject: json)
                request.httpBody = jsonData
            }
            session.dataTask(with: request, completionHandler: { (data, response, error) in
                result = data
                semaphore.signal()
            }).resume()
            semaphore.wait()
            return result
        }
        return nil
        }
}
