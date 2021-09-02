//
//  MediumTableCell.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/23/21.
//

import UIKit

class MediumTableCell: UICollectionViewCell {
  let name = UILabel()
  let subtitle = UILabel()
  let imageView = UIImageView()
  let buyButton = UIButton(type: .custom)

  override init(frame: CGRect) {
      super.init(frame: frame)

      name.font = UIFont.preferredFont(forTextStyle: .headline)
      name.textColor = .label

      subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
      subtitle.textColor = .secondaryLabel

      imageView.layer.cornerRadius = 15
      imageView.clipsToBounds = true

      buyButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)

      imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      buyButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)

      let innerStackView = UIStackView(arrangedSubviews: [name, subtitle])
      innerStackView.axis = .vertical

      let outerStackView = UIStackView(arrangedSubviews: [imageView, innerStackView, buyButton])
      outerStackView.translatesAutoresizingMaskIntoConstraints = false
      outerStackView.alignment = .center
      outerStackView.spacing = 10
      contentView.addSubview(outerStackView)

      NSLayoutConstraint.activate([
          outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
          outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
          outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor)
      ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - SelfConfiguringCell
extension MediumTableCell: SelfConfiguringCell {
  static var reuseIdentifier: String {
    return "MediumTableCell"
  }
  
  func configure(with app: App) {
      name.text = app.name
      subtitle.text = app.subheading
      imageView.image = UIImage(named: app.image)
  }
}
