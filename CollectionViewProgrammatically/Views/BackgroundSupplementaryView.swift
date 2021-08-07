//
//  BackgroundSupplementaryView.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/7/21.
//

import UIKit
// A sumpplementary view used for section backgrounds in UICollectionViewCompositionalLayout
final class BackgroundSupplementaryView: UICollectionReusableView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layer.cornerRadius = 8
    backgroundColor = .green
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
