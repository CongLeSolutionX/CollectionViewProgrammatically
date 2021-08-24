//
//  AppStoreViaCollectionViewDiffable.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/23/21.
//

import UIKit

class AppStoreViaCollectionViewDiffable: UIViewController {
  
  let sections = Bundle.main.decode([Section].self, from: "AppStoreData.json")
  
  var dataSource: UICollectionViewDiffableDataSource<Section, App>?
  
  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .lightGray
    
    collectionView.register(
      SectionHeader.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: SectionHeader.reuseIdentifier
    )
    
    collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
    collectionView.register(MediumTableCell.self, forCellWithReuseIdentifier: MediumTableCell.reuseIdentifier)
    collectionView.register(SmallTableCell.self, forCellWithReuseIdentifier: SmallTableCell.reuseIdentifier)

    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue
    navigationItem.title = "App Center Layout via Collection View Diffable"
    view.addSubview(collectionView)
    
    setupConstraints()
    
    createDataSource()
    
    reloadData()
    
  }
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

//MARK: - Setup data source
extension AppStoreViaCollectionViewDiffable {
  func createDataSource() {
      dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView) { collectionView, indexPath, app in
          switch self.sections[indexPath.section].type {
          case "mediumTable":
              return self.configure(MediumTableCell.self, with: app, for: indexPath)
          case "smallTable":
              return self.configure(SmallTableCell.self, with: app, for: indexPath)
          default:
              return self.configure(FeaturedCell.self, with: app, for: indexPath)
          }
      }

      dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
          guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
              return nil
          }

          guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
          guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return nil }
          if section.title.isEmpty { return nil }

          sectionHeader.title.text = section.title
          sectionHeader.subtitle.text = section.subtitle
          return sectionHeader
      }
  }
  
  func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with app: App, for indexPath: IndexPath) -> T {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
          fatalError("Unable to dequeue \(cellType)")
      }

      cell.configure(with: app)
      return cell
  }
  
  func reloadData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, App>()
    snapshot.appendSections(sections)

    for section in sections {
        snapshot.appendItems(section.items, toSection: section)
    }

    dataSource?.apply(snapshot)
  }
}
//MARK: - Construct Composition Layout
extension AppStoreViaCollectionViewDiffable {
  func createCompositionalLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
        let section = self.sections[sectionIndex]

        switch section.type {
        case "mediumTable":
            return self.createMediumTableSection(using: section)
        case "smallTable":
            return self.createSmallTableSection(using: section)
        default:
            return self.createFeaturedSection(using: section)
        }
    }

    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = 20
    layout.configuration = config
    return layout
  }
  
  func createFeaturedSection(using section: Section) -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(350))
      let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
      return layoutSection
  }
  
  func createMediumTableSection(using section: Section) -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))

      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
      let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.orthogonalScrollingBehavior = .groupPagingCentered

      let layoutSectionHeader = createSectionHeader()
      layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

      return layoutSection
  }
  
  func createSmallTableSection(using section: Section) -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)

      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(200))
      let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      let layoutSectionHeader = createSectionHeader()
      layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

      return layoutSection
  }
  
  func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
      let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
      let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      return layoutSectionHeader
  }
}
