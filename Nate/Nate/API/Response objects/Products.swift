//
//  Products.swift
//  Nate
//
//  Created by Robin Hellgren on 19/08/2020.
//  Copyright © 2020 Robin Hellgren. All rights reserved.
//

import Foundation

public struct Products: Codable {
    public let posts: [Post]

    public struct Post: Codable {
        public let id: String
        public let createdAt: Date
        public let updatedAt: Date
        public let title: String
        public let images: [URL]
        public let url: URL
        public let merchant: String
    }
}
