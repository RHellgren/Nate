//
//  ProductListTableViewCell.swift
//  Nate
//
//  Created by Robin Hellgren on 20/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import UIKit

final class ProductListTableViewCell: UITableViewCell {

    @IBOutlet private var innerView: UIView!
    @IBOutlet private var productImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var merchantLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none

        innerView.layer.cornerRadius = 8
        innerView.layer.shadowColor = UIColor.black.cgColor
        innerView.layer.shadowOpacity = 0.1
        innerView.layer.shadowOffset = .zero
        innerView.layer.shadowRadius = 8
    }

    func configure(viewModel: ProductListTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        merchantLabel.text = "Merchant: \(viewModel.merchant)"
        // TODO: Add image from URL
    }
}

struct ProductListTableViewCellViewModel {
    let title: String
    let merchant: String
    let imageURL: URL?
}
