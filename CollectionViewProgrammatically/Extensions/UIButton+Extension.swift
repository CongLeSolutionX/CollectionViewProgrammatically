//
//  UIButton+Extension.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/22/21.
//

import UIKit

extension UIButton {
  func roundedActionButton(withText text: String) {
      let bgColor: UIColor = text == AppAccess.onCloud.description
        ? .clear
        : .buttonBackgroundColor
    
      backgroundColor = bgColor
    
      if text == AppAccess.onCloud.description {
          setTitle("", for: .normal)
          setImage(UIImage(named: text), for: .normal)
      } else {
        setTitle(text, for: .normal)
      }
      titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
      layer.cornerRadius = 15
      contentEdgeInsets = UIEdgeInsets(top: 5.5, left: 0, bottom:5.5, right: 0)
  }
}
