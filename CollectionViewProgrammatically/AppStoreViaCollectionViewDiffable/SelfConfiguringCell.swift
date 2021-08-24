//
//  SelfConfiguringCell.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/23/21.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with app: App)
}
