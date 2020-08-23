//
//  NateTests.swift
//  NateTests
//
//  Created by Robin Hellgren on 22/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import XCTest
@testable import Insomnia
@testable import Nate

class NateTests: XCTestCase {
    var session: URLSessionMock!
    var api: InsomniaAPI!
    var dataService: DataService!

    override func setUpWithError() throws {
        session = URLSessionMock()
        api = InsomniaAPI(session: session)
        dataService = DataService(api: api)
    }

    override func tearDownWithError() throws {
        session = nil
        api = nil
        dataService = nil
    }

    func testSuccessfulResponse() {
        session.data = getData(name: "Products")

        dataService.getProducts(offset: 0) { products in
            XCTAssertEqual(products.count, 3)
            XCTAssertEqual(products.first?.id, "d42c4e87-5789-4840-9978-65e0c333ff8a")
        }
    }

    func testFailedRequest() {
        session.statusCode = 404

        dataService.getProducts(offset: 0) { products in
            XCTAssertEqual(products.count, 0)
        }
    }

    private func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
}
