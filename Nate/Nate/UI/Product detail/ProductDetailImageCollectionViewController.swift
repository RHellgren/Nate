//
//  ProductDetailImageCollectionViewController.swift
//  Nate
//
//  Created by Robin Hellgren on 20/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

final class ProductDetailImageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var imageURLs: [URL] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .clear
        collectionView.register(ProductDetailImageCollectionViewCell.self)
        collectionView.delegate = self
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductDetailImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(imageURL: imageURLs[indexPath.row])
        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
