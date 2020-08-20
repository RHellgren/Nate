//
//  UIViewController+Extensions.swift
//  Nate
//
//  Created by Robin Hellgren on 20/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import UIKit

extension UIViewController {
    static var storyboardName: String {
        return String(describing: self)
    }

    static func instantiate<T: UIViewController>() -> T {
        let storyboard = UIStoryboard(name: T.storyboardName, bundle: nil)

        guard let viewController = storyboard.instantiateInitialViewController() as? T else {
            fatalError("Could not instantiate initial storyboard with name: \(T.storyboardName)")
        }

        return viewController
    }
}
