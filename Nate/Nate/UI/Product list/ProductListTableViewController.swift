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
    private var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ProductListTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.backgroundColor = UIColor.primaryBackground

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

    // MARK: - UITableViewDataDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel.productDetailViewModel(for: indexPath.row) else {
            return
        }

        let viewController: ProductDetailViewController = ProductDetailViewController.instantiate()
        viewController.viewModel = viewModel

        present(viewController, animated: true)
    }

    // MARK: - UITableView infinite scroll

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - (2 * scrollView.frame.height)) && !isLoading {
            loadMoreData()
        }
    }

    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            viewModel.fetchNewReleases()
        }
    }
}

extension ProductListTableViewController: ProductListTableViewModelDelegate {
    func onFetchCompleted() {
        tableView.reloadData()
        isLoading = false
    }
}
