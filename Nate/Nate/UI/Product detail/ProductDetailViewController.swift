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

    func updateUI() {
        guard let viewModel = viewModel else {
            return
        }

        titleLabel.text = viewModel.title
        merchantLabel.text = "Sold by merchant: \(viewModel.merchant)"
    }

    @IBAction func didPressClose(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func didPressShow(_ sender: Any) {
        if let url = viewModel?.link {
            UIApplication.shared.openURL(url)
        }
    }
}
