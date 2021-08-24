//
//  UIImageView+Extension.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/22/21.
//

import UIKit

extension UIImageView {
  func configureAppIconView(forImage appImage: UIImage, size: CGFloat) {
    image = appImage
    contentMode = .scaleAspectFit
    layer.cornerRadius = size / 5.0
    layer.borderColor = UIColor.borderColor.cgColor
    layer.borderWidth = 0.5
    clipsToBounds = true
  }
}
