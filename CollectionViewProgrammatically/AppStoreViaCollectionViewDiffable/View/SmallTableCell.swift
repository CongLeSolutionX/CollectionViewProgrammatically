//
//  SmallTableCell.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/23/21.
//

import UIKit

class SmallTableCell: UICollectionViewCell {
  let name = UILabel()
  let imageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    name.font = UIFont.preferredFont(forTextStyle: .title2)
    name.textColor = .label
    
    imageView.layer.cornerRadius = 5
    imageView.clipsToBounds = true
    
    let stackView = UIStackView(arrangedSubviews: [imageView, name])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .center
    stackView.spacing = 20
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - SelfConfiguringCell
extension SmallTableCell: SelfConfiguringCell {
  static var reuseIdentifier: String {
    return "SmallTableCell"
  }
  
  func configure(with app: App) {
    name.text = app.name
    imageView.image = UIImage(named: app.image)
  }
}
