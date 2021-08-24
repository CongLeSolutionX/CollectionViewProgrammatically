//
//  CardView.swift
//  CardView
//
//  Created by Cong Le on 8/20/21.
//

import UIKit

class CardView: UIView {
  lazy var shadowView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    return view
  }()
  
  lazy var containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    return view
  }()
  
  lazy var backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  var featuredTitleCenter: NSLayoutConstraint = NSLayoutConstraint()
  
  lazy var featuredTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.layer.shadowOffset = CGSize(width: -1, height: 1)
    label.layer.shadowOpacity = 0.1
    label.layer.shadowRadius = 5
    label.textColor = .heroTextColor
    return label
  }()
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .singleLine
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 65, bottom: 0, right: 0)
    tableView.isScrollEnabled = false
        tableView.registerCell(GenericTableViewCell<AppView>.self)
    return tableView
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    //      label.textColor = cardModel.backgroundType.titleTextColor
    return label
  }()
  
  var subtitleTop: NSLayoutConstraint = NSLayoutConstraint()
  lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    //      label.textColor = cardModel.backgroundType.subtitleTextColor
    return label
  }()
  
  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    //      label.textColor = cardModel.backgroundType.subtitleTextColor
    return label
  }()
  
  var cardModel: CardViewModel
  var appView: AppView?
  
  var leadingConstraint: NSLayoutConstraint = NSLayoutConstraint()
  var trailingConstraint: NSLayoutConstraint = NSLayoutConstraint()
  var topConstraint: NSLayoutConstraint = NSLayoutConstraint()
  var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
  
  var appViewTop: NSLayoutConstraint = NSLayoutConstraint()
  
  init(cardModel: CardViewModel, appView: AppView?) {
    self.cardModel = cardModel
    self.appView = appView
    
    super.init(frame: .zero)
    
    appView?.backgroundType = cardModel.backgroundType
    
    leadingConstraint = containerView.leadingAnchor.constraint(equalTo: leadingAnchor)
    trailingConstraint = containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
    topConstraint = containerView.topAnchor.constraint(equalTo: topAnchor)
    bottomConstraint = containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
    
    configureViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//MARK: - Configure Views
extension CardView {
  
  func configureViews() {
    backgroundColor = .lightGray
    addSubview(shadowView)
    addSubview(containerView)
    
    if cardModel.viewMode == .card {
      convertContainerViewToCardView()
    } else {
      convertContainerViewToFullScreen()
    }
    
    NSLayoutConstraint.activate([
      shadowView.topAnchor.constraint(equalTo: containerView.topAnchor),
      shadowView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      shadowView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      shadowView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    ])
    
    addConstraints([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    
    switch cardModel.viewType {
    case .appOfTheDay:
      addBackgroundImage(withApp: true)
      addFeaturedTitle()
      
    case .appArticle:
      addBackgroundImage(withApp: false)
      addTopTitleLabels()
      addDescriptionLabel()
      
    case .appCollection:
      addTopTitleLabels()
      addAppCollection()
    }
  }
  
  func convertContainerViewToCardView() {
    updateLayout(for: .card)
    
    containerView.layer.cornerRadius = 20
    containerView.layer.masksToBounds = true
  }
  
  func convertContainerViewToFullScreen() {
    updateLayout(for: .full)
    
    containerView.layer.cornerRadius = 0
    containerView.layer.masksToBounds = true
  }
  
  func updateLayout(for viewMode: CardViewMode) {
    switch viewMode {
    case .card:
      leadingConstraint.constant = 20
      trailingConstraint.constant = -20
      topConstraint.constant = 15
      bottomConstraint.constant = -15
      
      subtitleTop.constant = 20
      featuredTitleCenter.constant = 20
      appViewTop.constant = 25
      
      addShadow()
    case .full:
      
      let topPadding = UIWindow.topPadding
      
      leadingConstraint.constant = 0
      trailingConstraint.constant = 0
      topConstraint.constant = 0
      bottomConstraint.constant = 0
      
      subtitleTop.constant = max(20, topPadding)
      featuredTitleCenter.constant = max(20, topPadding)
      appViewTop.constant = max(25, topPadding + 5)
      
      tableView.reloadData()
      
      removeShadow()
    }
  }
  
  func removeShadow() {
    shadowView.layer.shadowColor = UIColor.clear.cgColor
    shadowView.layer.shadowOpacity = 0
    shadowView.layer.shadowRadius = 0
    shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
  }
  
  func addShadow() {
    shadowView.layer.cornerRadius = 20
    shadowView.layer.shadowColor = UIColor.black.cgColor
    shadowView.layer.shadowOpacity = 0.2
    shadowView.layer.shadowRadius = 10
    shadowView.layer.shadowOffset = CGSize(width: -1, height: 2)
  }
  
  // MARK: - Configure Different Card Views -
  func configure(with viewModel: CardViewModel) {
    self.cardModel = viewModel
    
    if let appViewModel = viewModel.app {
      self.appView?.configure(with: appViewModel)
    } else {
      self.appView = nil
    }
    
    switch cardModel.viewType {
    case .appOfTheDay:
      hide(views: [titleLabel, subtitleLabel, descriptionLabel, tableView])
      addBackgroundImage(withApp: true)
      addFeaturedTitle()
      
    case .appArticle:
      hide(views: [featuredTitleLabel, tableView])
      addBackgroundImage(withApp: false)
      addTopTitleLabels()
      addDescriptionLabel()
      
    case .appCollection:
      addTopTitleLabels()
      addAppCollection()
    }
  }
  
  func hide(views: [UIView]) {
    views.forEach { $0.removeFromSuperview()}
  }
  
  func show(views: [UIView]) {
    views.forEach { $0.isHidden = false }
  }
  
  // MARK: - Background Image -
  private func addBackgroundImage(withApp hasApp: Bool) {
    configureBackgroundImage()
    
    containerView.addSubview(backgroundImageView)
    
    NSLayoutConstraint.activate([
      backgroundImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      backgroundImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      backgroundImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      backgroundImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
    ])
    
    guard let appView = appView else { return }
    appView.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(appView)
    
    let topPadding = UIWindow.topPadding
    var top: CGFloat = 25.0
    
    if cardModel.viewMode == .full {
      top = max(top, topPadding + 5)
    }
    
    appViewTop = appView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: top)
    
    NSLayoutConstraint.activate([
      appViewTop,
      appView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25.0),
      appView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25.0),
      appView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -25.0)
    ])
  }
  
  private func configureBackgroundImage() {
    guard let backgroundImage = cardModel.backgroundImage else { return }
    backgroundImageView.image = backgroundImage
  }
  
  // MARK: - Featured Title -
  private func addFeaturedTitle() {
    containerView.addSubview(featuredTitleLabel)
    
    let topPadding = UIWindow.topPadding
    var center: CGFloat = 20.0
    
    if cardModel.viewMode == .full {
      center = max(center, topPadding)
    }
    
    featuredTitleCenter = featuredTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: center)
    
    NSLayoutConstraint.activate([
      featuredTitleCenter,
      featuredTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20.0),
      featuredTitleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6)
    ])
    
    configureFeaturedTitle()
  }
  
  private func configureFeaturedTitle() {
    featuredTitleLabel.configureHeroLabel(withText: "APP\nOF THE\nDAY")
  }
  
  // MARK: - Top Title Labels -
  private func addTopTitleLabels() {
    configureTopTitleLabels()
    
    containerView.addSubview(subtitleLabel)
    containerView.addSubview(titleLabel)
    
    let topPadding = UIWindow.topPadding
    var top: CGFloat = 20.0
    if cardModel.viewMode == .full {
      top = max(top, topPadding)
    }
    
    subtitleTop = subtitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: top)
    
    NSLayoutConstraint.activate([
      subtitleTop,
      subtitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20.0),
      subtitleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20.0),
      
      titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5.0),
      titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20.0),
      titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20.0),
      
    ])
  }
  
  private func configureTopTitleLabels() {
    guard let subtitle = cardModel.subtitle,
          let title = cardModel.title else { return }
    
    subtitleLabel.configureSubHeaderLabel(withText: subtitle.uppercased())
    titleLabel.configureHeaderLabel(withText: title)
  }
  
  // MARK: - Description Label -
  private func addDescriptionLabel() {
    configureDescriptionLabel()
    containerView.addSubview(descriptionLabel)
    
    NSLayoutConstraint.activate([
      descriptionLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20.0),
      descriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -40.0),
      descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15.0)
    ])
  }
  
  private func configureDescriptionLabel() {
    guard let description = cardModel.description else { return }
    
    descriptionLabel.configureAppSubHeaderLabel(withText: description)
  }
  
  // MARK: - App Collection -
  private func addAppCollection() {
    containerView.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20.0),
      tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15.0),
      tableView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20.0),
      tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20.0)
    ])
    
    tableView.reloadData()
  }
}

// MARK: - UITableViewDelegate
extension CardView: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70.0
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
}

// MARK: - UITableViewDataSource
extension CardView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let appCell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<AppView>
    return appCell
  }
}
