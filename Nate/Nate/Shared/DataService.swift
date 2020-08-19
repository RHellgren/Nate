//
//  DataService.swift
//  Nate
//
//  Created by Robin Hellgren on 19/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import Foundation
import Insomnia

class DataService {
    private let api = Insomnia.InsomniaAPI()

    func getProducts(offset: Int?, completion: @escaping ([Product]) -> Void) {
        api.getProducts(offset: offset ?? 0) { apiProducts in
            guard let apiProducts = apiProducts else {
                completion([])
                return
            }

            let products = apiProducts.posts.map {
                Product(id: $0.id,
                        createdAt: $0.createdAt,
                        updatedAt: $0.updatedAt,
                        title: $0.title,
                        images: $0.images,
                        url: $0.url,
                        merchant: $0.merchant)
            }

            completion(products)
            return
        }
    }
}
