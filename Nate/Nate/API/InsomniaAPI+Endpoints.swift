//
//  InsomniaAPI+Endpoints.swift
//  Insomnia
//
//  Created by Robin Hellgren on 19/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import Foundation

extension InsomniaAPI {

    public func getProducts(offset: Int, completion: @escaping (Products?) -> Void) {

        guard let request = createRequest(
            path: "/products/offset",
            method: .post,
            body: ["skip": offset, "take": 20]) else {
                completion(nil)
                return
        }

        perform(request) { (result: Result<Products, APIError>) in
            switch result {
            case .success(let newReleases):
                completion(newReleases)

            case .failure(let error):
                print("Failed to get products, error: \(error)")
                completion(nil)
            }
        }
    }
}
