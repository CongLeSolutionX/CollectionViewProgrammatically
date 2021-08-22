//
//  ViewController.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/6/21.
//

import UIKit
class CompositionalLayoutViewController: UIViewController {
  let categoryHeaderId = "categoryHeaderId"
  let headerId = "headerId"
  
  private enum FlowLayoutConstant {
    static let numberOfItemsPerRow: CGFloat = 2.0
  }
  
  lazy var collectionView = makeCollectionView()
  
  override func loadView() {
    super.loadView()
    view.backgroundColor = .red
    view.addSubview(collectionView)
    setupConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Compositional Layout View Controller"
    navigationItem.largeTitleDisplayMode = .always
  
  }
}

//MARK: - Setup constraints
extension CompositionalLayoutViewController {
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
extension CompositionalLayoutViewController {
  private func makeCollectionView() -> UICollectionView {
    let compositionalLayout = createCompositionalLayout()
    compositionalLayout.register(BackgroundSupplementaryView.self, forDecorationViewOfKind: "background")
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .yellow
    
    collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
    collectionView.register(CategoryHeaderView.self, forSupplementaryViewOfKind: categoryHeaderId, withReuseIdentifier: headerId)
    return collectionView
  }
}

// MARK: - Helper methods to crete compositionl Layout
extension CompositionalLayoutViewController {
  /// CompositionalLayout feature is only available for iOS 13 and above
  /// Compositional Layout support for both portrait and landscape mode without extra contraints
  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionNumber, environemnt) -> NSCollectionLayoutSection? in
      switch sectionNumber {
      case 0: return self.firstLayoutSection()
      case 1: return self.secondLayoutSection()
      case 2: return self.thirdLayoutSection()
      default:
        return self.fourthLayoutSection()
      }
    }
  }
  
  private func firstLayoutSection() -> NSCollectionLayoutSection {
    /// `fractionalWidth` sets the width/height of the cell proportional to its parent’s width
    /// `fractionalHeight` sets the width/height of the cell proportional to its parent’s height
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),  // the group width is 1x the containing section's width
      heightDimension: .fractionalHeight(1) // the group height is 1x the containing section's height
    )
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.9), // the group width is 0.9x the containing section's width
      heightDimension: .fractionalWidth(0.5) // the group height is 0.5x the containing section's height
    )
    
    // all items in group will be placed horizontally in the layout
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    // insets between each items
    group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2)
    
    let section = NSCollectionLayoutSection(group: group) // a single section can contain multiple groups
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
    section.boundarySupplementaryItems = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(44)),
        elementKind: categoryHeaderId,
        alignment: .topLeading
      )
    ]
    section.orthogonalScrollingBehavior = .groupPaging
    
    return section
  }
  
  private func secondLayoutSection() -> NSCollectionLayoutSection {
    /// Since items in this section scroll vertically, we cannot describe out group height based on the sections's height.
    /// Also, the section's height is dependent on the  number of items in our data source, and that has nothing todo  with the group size.
    /// Thus, we need `absolute` value  or `estimate` value.
    /// `absolute` value can set the width/height of the cell to a fixed value
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1/3),  // divide items in 3 columns
      heightDimension: .absolute(100)         // each item cell has a fixed height of 100
    )
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    // insets between each items
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 15)
    
    /// `estimate` value can set the cell’s width/height according to the content size.
    /// The system will decide the optimal width/height for the content.
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1), //group size have the full width of its parent section
      heightDimension: .estimated(500) // we need a system to decide height based on content with estimate of 500
    )
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
    section.boundarySupplementaryItems = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(44)),
        elementKind: categoryHeaderId,
        alignment: .topLeading
      )
    ]
    
    let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
    let backgroundInset: CGFloat = 8.0
    backgroundItem.contentInsets = NSDirectionalEdgeInsets(top: backgroundInset, leading: backgroundInset, bottom: backgroundInset, trailing: backgroundInset)
    section.decorationItems = [backgroundItem]
    
    return section
  }
  
  private func thirdLayoutSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalHeight(1)
    )
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.8),
      heightDimension: .fractionalWidth(0.35)
    )
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    // insets between each items
    group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
   
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
    section.boundarySupplementaryItems = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(44)),
        elementKind: categoryHeaderId,
        alignment: .topLeading
      )
    ]
    section.orthogonalScrollingBehavior = .continuous
    
    return section
  }
  
  private func fourthLayoutSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1/2),  // divide items in 3 columns
      heightDimension: .absolute(100)         // each item cell has a fixed height of 100
    )
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    // insets between each items
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 15)
    
    /// `estimate` value can set the cell’s width/height according to the content size.
    /// The system will decide the optimal width/height for the content.
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1), //group size have the full width of its parent section
      heightDimension: .estimated(500) // we need a system to decide height based on content with estimate of 500
    )
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
    section.boundarySupplementaryItems = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(44)),
        elementKind: categoryHeaderId,
        alignment: .topLeading
      )
    ]
    
    let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
    let backgroundInset: CGFloat = 8.0
    backgroundItem.contentInsets = NSDirectionalEdgeInsets(top: backgroundInset, leading: backgroundInset, bottom: backgroundInset, trailing: backgroundInset)
    section.decorationItems = [backgroundItem]
    return section
  }
}

//MARK: - UICollectionViewDelegate
extension CompositionalLayoutViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("Clicked on collection cell at indexpath \(indexPath.row)")
  }
}

// MARK: - UICollectionViewDataSource
extension CompositionalLayoutViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 3
    case 1:
      return 6
    case 2:
      return 4
    default:
      return 10
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else {
      fatalError("Cannot dequeue collection cell")
    }
    cell.bindingData = sampleData[indexPath.row]
    cell.backgroundColor = .blue
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
    return header
  }
}
