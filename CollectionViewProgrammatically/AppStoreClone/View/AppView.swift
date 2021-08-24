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
  
  private let appViewType: AppViewType
  
  var viewModel: AppViewModel
  init?(_ viewModel: AppViewModel?) {
    guard let viewModel = viewModel else { return nil }
    self.viewModel = viewModel
    self.appViewType = viewModel.appViewType
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension AppView {
  func configure(with viewModel: AppViewModel) {
    self.viewModel = viewModel
    
  }
  
  func configureViews() {
    iconImageView.configureAppIconView(forImage: viewModel.iconImage, size: appViewType.imageSize)
    titleLabel.configureAppHeaderLabel(withText: viewModel.name)
    subtitleLabel.configureAppSubHeaderLabel(withText: viewModel.category.description.uppercasedFirstLetter)
    buttonSubtitleLabel.configureTinyLabel(withText: "In-App Purchases")
    getButton.roundedActionButton(withText: viewModel.appAccess.description)
  }
}
