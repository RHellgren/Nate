//
//  URLSessionMock.swift
//  NateTests
//
//  Created by Robin Hellgren on 22/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    var data: Data?
    var error: Error?
    var statusCode: Int?

    override init() { }

    override func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let response = HTTPURLResponse(url: request.url!,
                                       statusCode: statusCode ?? 200,
                                       httpVersion: nil,
                                       headerFields: nil)

        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}
