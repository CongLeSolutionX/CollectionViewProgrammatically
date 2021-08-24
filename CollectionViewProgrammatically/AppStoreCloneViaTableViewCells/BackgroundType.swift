//
//  BackgroundType.swift
//  BackgroundType
//
//  Created by Cong Le on 8/20/21.
//

import UIKit

enum BackgroundType: String {
case light
case dark
  
  var titleTextColor: UIColor {
    switch self {
    case .dark:
      return .lightTitleTextColor
    case .light:
      return .darkTitleTextColor
    }
  }
  
  var subtitleTextColor: UIColor {
    switch self{
    case .dark:
      return .lightSubtitleTextColor
    case .light:
      return .darkSubtitleTextColor
    }
  }
}
