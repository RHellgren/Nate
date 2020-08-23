//
//  URLSessionDataTaskMock.swift
//  NateTests
//
//  Created by Robin Hellgren on 22/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
