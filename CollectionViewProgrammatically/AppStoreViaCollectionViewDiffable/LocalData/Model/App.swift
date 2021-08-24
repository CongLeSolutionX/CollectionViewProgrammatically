//
//  App.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/23/21.
//

import Foundation

struct App: Decodable, Hashable {
    let id: Int
    let tagline: String
    let name: String
    let subheading: String
    let image: String
    let iap: Bool
}
