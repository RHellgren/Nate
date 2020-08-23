//
//  ProductDetailViewController.swift
//  Nate
//
//  Created by Robin Hellgren on 20/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet private var closeButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var merchantLabel: UILabel!
    @IBOutlet private var showButton: UIButton!

    var viewModel: ProductDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProductDetailImageCollectionViewController {
            destination.imageURLs = viewModel?.imageURLs ?? []
        }
    }

    private func updateUI() {
        guard let viewModel = viewModel else {
            return
        }

        view.backgroundColor = UIColor.primaryBackground

        closeButton.setTitleColor(UIColor.secondaryInteractionText, for: .normal)

        titleLabel.text = viewModel.title
        titleLabel.textColor = UIColor.primaryText

        if viewModel.merchant.count > 0 {
            merchantLabel.text = "Sold by merchant: \(viewModel.merchant)"
            merchantLabel.textColor = UIColor.secondaryText
        } else {
            merchantLabel.isHidden = true
        }

        updateShowButton()
    }

    private func updateShowButton() {
        guard let url = viewModel?.link,
            UIApplication.shared.canOpenURL(url) else {
                showButton.isHidden = true
                return
        }

        showButton.backgroundColor = UIColor.primaryInteractionBackground
        showButton.setTitleColor(UIColor.primaryInteractionText, for: .normal)
        showButton.layer.cornerRadius = 8
        showButton.layer.shadowColor = UIColor.shadow.cgColor
        showButton.layer.shadowOffset = .zero
        showButton.layer.shadowRadius = 8
        showButton.layer.shadowOpacity = 0.3
    }

    @IBAction func didPressClose(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func didPressShow(_ sender: Any) {
        guard let url = viewModel?.link else {
           return
        }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
