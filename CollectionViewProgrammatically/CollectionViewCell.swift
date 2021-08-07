//
//  CollectionViewCell.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/6/21.
//

import UIKit
class CollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "collectionViewCell"
 
  var data: SampleData? {
    didSet {
      guard let data = data else { return }
      label.text = data.imageName
      imageView.image = UIImage(named: data.imageName)
    }
  }
  
  lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.layer.cornerRadius = 10
    view.clipsToBounds = true
    view.contentMode = .scaleToFill
    return view
  }()
  
  let label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imageView)
    contentView.addSubview(label)
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupConstraints() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0),
      label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
    ])
  }
}
