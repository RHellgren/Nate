//
//  ProductListTableViewModel.swift
//  Nate
//
//  Created by Robin Hellgren on 20/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import Foundation

protocol ProductListTableViewModelDelegate {
    func onFetchCompleted()
}

final class ProductListTableViewModel {
    var products: [Product] = []
    var delegate: ProductListTableViewModelDelegate?
    private var isFetchInProgress = false
    private var currentPage = 0

    func fetchNewReleases() {
        guard !isFetchInProgress else {
          return
        }

        isFetchInProgress = true

        DataService().getProducts(offset: currentPage) { products in
            self.isFetchInProgress = false
            self.currentPage += 1

            self.products.append(contentsOf: products)
            self.delegate?.onFetchCompleted()
        }
    }

    func cellViewModel(for index: Int) -> ProductListTableViewCellViewModel? {
        guard products.indices.contains(index) else {
            return nil
        }

        let product = products[index]

        return ProductListTableViewCellViewModel(title: product.title,
                                                 merchant: product.merchant,
                                                 imageURL: product.images.first)
    }

    func productDetailViewModel(for index: Int) -> ProductDetailViewModel? {
        guard products.indices.contains(index) else {
            return nil
        }

        let product = products[index]

        return ProductDetailViewModel(imageURLs: product.images,
                                      title: product.title,
                                      merchant: product.merchant,
                                      link: product.url)
    }
}
