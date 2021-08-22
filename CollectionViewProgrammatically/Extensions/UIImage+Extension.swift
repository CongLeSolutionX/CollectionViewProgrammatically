//
//  UIImage+Extension.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/21/21.
//

import UIKit.UIImage

extension UIImage{
  
  func imageWith(newSize: CGSize) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: newSize)
    let image = renderer.image { _ in
      draw(in: CGRect.init(origin: .zero, size: newSize))
    }
    
    return image
  }
}
