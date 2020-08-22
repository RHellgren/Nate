//
//  ProductListTableViewCell.swift
//  Nate
//
//  Created by Robin Hellgren on 20/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import UIKit
import Kingfisher

final class ProductListTableViewCell: UITableViewCell {

    @IBOutlet private var innerView: UIView!
    @IBOutlet private var productImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var merchantLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none

        innerView.layer.cornerRadius = 8
        innerView.layer.shadowColor = UIColor.shadow.cgColor
        innerView.layer.shadowOffset = .zero
        innerView.layer.shadowRadius = 8
        innerView.layer.shadowOpacity = 0.1
        innerView.backgroundColor = UIColor.secondaryBackground

        productImageView.layer.cornerRadius = 8
        productImageView.contentMode = .scaleAspectFill

        titleLabel.textColor = UIColor.primaryText
        merchantLabel.textColor = UIColor.secondaryText
    }

    func configure(viewModel: ProductListTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        merchantLabel.text = "Merchant: \(viewModel.merchant)"

        if let url = viewModel.imageURL {
            productImageView.kf.indicatorType = .activity
            productImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "ProductImagePlaceholder"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        } else {
            productImageView.image = UIImage(named: "ProductImageMissing")
        }
    }
}

struct ProductListTableViewCellViewModel {
    let title: String
    let merchant: String
    let imageURL: URL?
}
