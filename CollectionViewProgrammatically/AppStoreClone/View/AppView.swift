//
//  AppView.swift
//  AppView
//
//  Created by Cong Le on 8/20/21.
//

import UIKit

class AppView: UIView {
  
  lazy var iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    return imageView
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = backgroundType.titleTextColor
    return label
  }()
  
  lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = backgroundType.subtitleTextColor
    return label
  }()
  
  lazy var buttonSubtitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = backgroundType.subtitleTextColor
    return label
  }()
  
  var backgroundType: BackgroundType = .light {
    didSet {
      titleLabel.textColor = backgroundType.titleTextColor
      subtitleLabel.textColor = backgroundType.subtitleTextColor
      buttonSubtitleLabel.textColor = backgroundType.subtitleTextColor
    }
  }
  
  lazy var getButton: UIButton = {
      let button = UIButton(type: UIButton.ButtonType.roundedRect)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
  }()
  
  lazy var labelsView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      
      return view
  }()
  
  lazy var detailsStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
  }()
  
//  var viewModel: AppViewModel
  
}

extension AppView {
  func configureViews() {
//    iconImageView.configure
  }
}
