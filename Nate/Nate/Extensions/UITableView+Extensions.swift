//
//  UITableView+Extensions.swift
//  Nate
//
//  Created by Robin Hellgren on 20/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        if Bundle.main.path(forResource: T.reuseIdentifier, ofType: "nib") != nil {
            let nib = UINib(nibName: T.reuseIdentifier, bundle: Bundle.main)

            register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }

        return cell
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
