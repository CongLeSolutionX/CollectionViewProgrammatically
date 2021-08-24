//
//  Section.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/23/21.
//

import Foundation
struct Section: Decodable, Hashable {
  let id: Int
  let type: String
  let title: String
  let subtitle: String
  let items: [App]
}
