//
//  ProductListTableViewController.swift
//  Nate
//
//  Created by Robin Hellgren on 20/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import UIKit

final class ProductListTableViewController: UITableViewController {

    var viewModel = ProductListTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ProductListTableViewCell.self)
        tableView.separatorStyle = .none

        viewModel.delegate = self
        viewModel.fetchNewReleases()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductListTableViewCell = tableView.dequeueReusableCell(for: indexPath)

        if let viewModel = viewModel.cellViewModel(for: indexPath.row) {
            cell.configure(viewModel: viewModel)
        }

        return cell
    }
}

extension ProductListTableViewController: ProductListTableViewModelDelegate {
    func onFetchCompleted() {
        tableView.reloadData()
    }
}
