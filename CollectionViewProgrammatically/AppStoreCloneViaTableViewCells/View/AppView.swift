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
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
// MARK: - configure the view based on different types of view
extension AppView {
  func setupViews() {
    configureViews()
//    configureLabelsView()
    
    switch appViewType {
    case .featured:
      addFeaturedTopViews()
    case .horizontal:
      addDetailViews()
    case .none:
      break
    }
  }
  
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
  
//  func configureLabelsView() {
//    labelsView.addSubview(subtitleLabel)
//    NSLayoutConstraint.activate([
//      subtitleLabel.leadingAnchor.constraint(equalTo: labelsView.leadingAnchor),
//      subtitleLabel.bottomAnchor.constraint(equalTo: labelsView.bottomAnchor),
//      subtitleLabel.widthAnchor.constraint(equalTo: labelsView.widthAnchor)
//    ])
//  }
}
// MARK: - add Featured Top Views
extension AppView {
  fileprivate func addFeaturedTopViews() {
    addSubview(iconImageView)
    addHorizontalLabelsAndButton()
    configureHorizontalLabelsAndButton()
    constraintsForFeaturedTopViews()
  }
  
  fileprivate func addHorizontalLabelsAndButton() {
    addSubview(labelsView)
    addSubview(getButton)
  }
  
  fileprivate func configureHorizontalLabelsAndButton() {
    NSLayoutConstraint.activate([
      labelsView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      labelsView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      labelsView.widthAnchor.constraint(equalTo: self.widthAnchor),
      
      getButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      getButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      getButton.widthAnchor.constraint(equalTo: self.widthAnchor)
    ])
  }
  
  fileprivate func constraintsForFeaturedTopViews() {
    NSLayoutConstraint.activate([
      iconImageView.topAnchor.constraint(equalTo: self.topAnchor),
      iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      iconImageView.heightAnchor.constraint(equalToConstant: appViewType.imageSize),
      iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor)
      
    ])
  }
  
}
// MARK: - add Detail Views
extension AppView {
  func addDetailViews() {
    
  }
}
