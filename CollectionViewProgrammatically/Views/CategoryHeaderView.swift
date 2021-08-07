//
//  CategoryHeaderView.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/7/21.
//

import UIKit
// A sumpplementary view used for the header view of collection view
final class CategoryHeaderView: UICollectionReusableView {
  lazy var label = makeLabel()
 
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(label)
    setupConstraint()
    
    layer.cornerRadius = 8
    backgroundColor = UIColor(white: 0.85, alpha: 1)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup UI Components
extension CategoryHeaderView {
  private func makeLabel() -> UILabel {
    let label = UILabel()
    label.text = "Section Title"
    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    return label
  }
  
  func setupConstraint() {
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor),
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      label.trailingAnchor.constraint(equalTo: trailingAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    ])
  }
}
