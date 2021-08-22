//
//  TodayView.swift
//  TodayView
//
//  Created by Cong Le on 8/20/21.
//
// Reference: https://github.com/andrei-blaj/appstoreclone

import UIKit

class AppStoreTodayLayoutViewController: UIViewController {
  // MARK: Views
  lazy var scrollView: UIScrollView = {
    let view = UIScrollView(frame: .zero)
    view.backgroundColor = .red
    view.autoresizingMask = .flexibleHeight
    view.showsHorizontalScrollIndicator = false
    view.showsVerticalScrollIndicator = false
    view.bounces = true
    view.delegate = self
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // MARK: - Top View -
  lazy var topView: UIView = {
    let view = UIView()
    view.backgroundColor = .yellow
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var dateLabel: UILabel = {
    let label = UILabel()
    //    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    label.text = "SATURDAY, AUGUST 21"
    label.textColor = .lightGray
    return label
  }()
  
  lazy var todayLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
    label.text = "Today"
    label.textColor = .black
    return label
  }()
  
  lazy var userImageView: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.backgroundColor = .clear
    image.contentMode = .scaleAspectFill
    image.layer.cornerRadius = 17.5
    image.layer.borderWidth = 0.25
    image.layer.borderColor = UIColor.lightGray.cgColor
    image.image = UIImage(named: "profile")
    image.clipsToBounds = true
    return image
  }()
  
  // MARK: - Cards Table View
  lazy var cardsTableView: UITableView = {
    let tableView = UITableView(frame: .zero)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
//    tableView.separatorStyle = .none
    tableView.backgroundColor = .gray
    tableView.registerCell(GenericTableViewCell<CardView>.self)
    return tableView
  }()
  
//  let cardViewData: [CardViewModel] = CardsData
  
  override func viewDidLoad() {
    configureView()
  }
  
  deinit {
    print("View deinit......")
  }
}

extension AppStoreTodayLayoutViewController {
  func configureView() {
    view.backgroundColor = .cyan
    navigationItem.title = "App Store Today Layout View Controller"
    configureScrollView()
    configureTopView()
    configureCardsView()
  }
  
  func configureScrollView() {
    view.addSubview(scrollView)
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  func configureTopView() {
    scrollView.addSubview(topView)
    NSLayoutConstraint.activate([
      topView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      topView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      topView.widthAnchor.constraint(equalToConstant: view.frame.size.width)
    ])
  }
  
  func configureCardsView() {
    scrollView.addSubview(cardsTableView)
    NSLayoutConstraint.activate([
      cardsTableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
      cardsTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      cardsTableView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
      cardsTableView.heightAnchor.constraint(equalToConstant: CGFloat(450 * 5)),
      cardsTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ])
  }
}

extension AppStoreTodayLayoutViewController: UIScrollViewDelegate {
  
}

// MARK: - UITableViewDelegate
extension AppStoreTodayLayoutViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 450
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("I am hit.")
  }
}

//MARK: - UITableViewDataSource
extension AppStoreTodayLayoutViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cardCell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<CardView>
    
    return cardCell
  }
}
