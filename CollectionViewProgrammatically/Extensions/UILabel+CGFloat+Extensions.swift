//
//  UILabel+Extensions.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/22/21.
//

import UIKit

extension CGFloat {
    static let heroTextSize: CGFloat = 50.0
    static let headerTextSize: CGFloat = 28.0
    static let subHeaderTextSize: CGFloat = 15.0
    static let appHeaderTextSize: CGFloat = 15.0
    static let appSubHeaderTextSize: CGFloat = 13.0
    static let tinyTextSize: CGFloat = 8.0
}

extension UILabel {
  func configureHeaderLabel(withText text: String) {
      configure(withText: text, size: .headerTextSize, alignment: .left, lines: 0, weight: .bold)
  }

  func configureSubHeaderLabel(withText text: String) {
      configure(withText: text, size: .subHeaderTextSize, alignment: .left, lines: 0, weight: .semibold)
  }

  func configureHeroLabel(withText text: String) {
      configure(withText: text, size: .heroTextSize, alignment: .left, lines: 0, weight: .heavy)
  }

  func configureAppHeaderLabel(withText text: String){
      configure(withText: text, size: .appHeaderTextSize, alignment: .left, lines: 2, weight: .medium)
  }

  func configureAppSubHeaderLabel(withText text: String) {
      configure(withText: text, size: .appSubHeaderTextSize, alignment: .left, lines: 2, weight: .regular)
  }

  func configureTinyLabel(withText text: String) {
      configure(withText: text, size: .tinyTextSize, alignment: .center, lines: 1, weight: .regular)
  }

  private func configure(withText newText: String,
                       size: CGFloat,
                       alignment: NSTextAlignment,
                       lines: Int,
                       weight: UIFont.Weight) {
      text = newText
      font = UIFont.systemFont(ofSize: size, weight: weight)
      textAlignment = alignment
      numberOfLines = lines
      lineBreakMode = .byTruncatingTail
  }
}
