//
//  String+Extension.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/21/21.
//

import Foundation

extension String {
  func boolValue() -> Bool? {
    switch lowercased() {
    case "true", "yes", "1":
      return true
    case "false", "no", "0":
      return false
    default:
      return nil
    }
  }
}
