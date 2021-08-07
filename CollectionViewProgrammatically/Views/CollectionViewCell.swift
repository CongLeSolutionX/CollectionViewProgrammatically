//
//  CollectionViewCell.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/6/21.
//

import UIKit
final class CollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "collectionViewCell"
  lazy var imageView = makeImageView()
  lazy var label = makeLabel()
  
  var bindingData: SampleData? {
    didSet {
      guard let data = bindingData else { return }
      label.text = data.imageName
      imageView.image = UIImage(named: data.imageName)
    }
  }
 
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imageView)
    contentView.addSubview(label)
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup constraints
extension CollectionViewCell {
  func setupConstraints() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0),
      label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0),
      
      imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
    ])
  }
}

// MARK: - Setup UI components
extension CollectionViewCell {
  private func makeImageView() -> UIImageView {
    let view = UIImageView()
    view.layer.cornerRadius = 10
    view.layer.masksToBounds = true
    view.contentMode = .scaleAspectFill
    return view
  }
  
  private func makeLabel() -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }
}
