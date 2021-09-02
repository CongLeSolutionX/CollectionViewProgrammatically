//
//  GenericTableViewCell.swift
//  GenericTableViewCell
//
//  Created by Cong Le on 8/20/21.
//

import UIKit

// A generic type conforms to UITableViewCell 
class GenericTableViewCell<View: UIView>: UITableViewCell {
  var cellView: View? {
    didSet {
      guard cellView != nil else { return }
      setupCellView()
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    
    selectionStyle = .none
    backgroundColor = .systemYellow//.backgroundColor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupCellView() {
    guard let cellView = cellView else { return }
    
    addSubview(cellView)
    cellView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      cellView.topAnchor.constraint(equalTo: self.topAnchor),
      cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}
