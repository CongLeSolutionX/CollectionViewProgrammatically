//
//  FlowLayoutViewController.swift
//  FlowLayout
//
//  Created by Cong Le on 8/20/21.
//

import Foundation
import UIKit

class FlowLayoutViewController: UIViewController {
  private enum FlowLayoutConstant {
    static let numberOfItemsPerRow: CGFloat = 2.0
  }
  
  lazy var flowLayout = makeFlowLayout()
  lazy var collectionView = makeCollectionView()
  
  override func loadView() {
    super.loadView()
    view.backgroundColor = .green
    view.addSubview(collectionView)
    setupConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Flow Layout View Controller"
    
  }
}

//MARK: - Setup constraints
extension FlowLayoutViewController {
  func setupConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) // use this coonstraint for vertical scroll
      // collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5)// use this constraint for horizontal scroll
    ])
  }
}

// MARK: - Setup UI components
extension FlowLayoutViewController {
  
  private func makeFlowLayout() -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    /// The `UICollectionViewDelegateFlowLayout` has similar methods to return the
    /// following flags: `minimumLineSpacing`, `minimumInteritemSpacing`, and `sectionInset`.
    /// But, we nested these flags in this lazy var for oranization and maintenance purposes
    layout.minimumLineSpacing = 5.0
    layout.minimumInteritemSpacing = 5.0
    layout.sectionInset = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    return layout
  }
  
  private func makeCollectionView() -> UICollectionView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .yellow
    collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
    return collectionView
  }
}

//MARK: - UICollectionViewDelegate
extension FlowLayoutViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("Clicked on collection cell at indexpath \(indexPath.row)")
  }
}

// MARK: - UICollectionViewDataSource
extension FlowLayoutViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sampleData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else {
      fatalError("Cannot dequeue collection cell")
    }
    
    cell.bindingData = sampleData[indexPath.row]
    cell.backgroundColor = .blue
    return cell
  }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension FlowLayoutViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    // Dynamically calculate the item's width based on the given number of items per row
    let collectionWidth = collectionView.bounds.width
    let spacingBetweenItems: CGFloat = flowLayout.minimumInteritemSpacing
    let availableWidth = collectionWidth - spacingBetweenItems * (FlowLayoutConstant.numberOfItemsPerRow + 1)
    let itemDimension = floor(availableWidth / FlowLayoutConstant.numberOfItemsPerRow)
    return CGSize(width: itemDimension, height: itemDimension)
  }
}
