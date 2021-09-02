//
//  FeaturedCell.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/23/21.
//

import UIKit

class FeaturedCell: UICollectionViewCell {
  let tagline = UILabel()
  let name = UILabel()
  let subtitle = UILabel()
  let imageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let separator = UIView(frame: .zero)
    separator.translatesAutoresizingMaskIntoConstraints = false
    separator.backgroundColor = .quaternaryLabel
    
    tagline.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
    tagline.textColor = .systemBlue
    
    name.font = UIFont.preferredFont(forTextStyle: .title2)
    name.textColor = .label
    
    subtitle.font = UIFont.preferredFont(forTextStyle: .title2)
    subtitle.textColor = .secondaryLabel
    
    imageView.layer.cornerRadius = 5
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    
    let stackView = UIStackView(arrangedSubviews: [separator, tagline, name, subtitle, imageView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      separator.heightAnchor.constraint(equalToConstant: 1),
      
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
    
    stackView.setCustomSpacing(10, after: separator)
    stackView.setCustomSpacing(10, after: subtitle)
  }
  
  required init?(coder: NSCoder) {
    fatalError("Not happening")
  }
}

//MARK: - SelfConfiguringCell 
extension FeaturedCell: SelfConfiguringCell {
  static var reuseIdentifier: String {
    return "FeaturedCell"
  }
  
  func configure(with app: App) {
    tagline.text = app.tagline.uppercased()
    name.text = app.name
    subtitle.text = app.subheading
    imageView.image = UIImage(named: app.image)
  }
}
