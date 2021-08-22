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
//    tableView.registerCell(GenericTableViewCell<AppView>.self)
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
  
  init(cardModel: CardViewModel) {
    self.cardModel = cardModel
    
    super.init(frame: .zero)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
