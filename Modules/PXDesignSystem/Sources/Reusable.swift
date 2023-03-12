//
//  Reusable.swift
//  PXDesignSystem
//
//  Created by Geonhee on 2023/03/13.
//

import UIKit

public protocol Reusable {
  static var reuseIdentifier: String { get }
}

public extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

public extension UICollectionView {
  func register<Cell: UICollectionViewCell>(cellType: Cell.Type) where Cell: Reusable {
    self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
  }

  func dequeueReusableCell<Cell: UICollectionViewCell>(
    cellType: Cell.Type,
    for indexPath: IndexPath
  ) -> Cell where Cell: Reusable {
    guard let cell = self.dequeueReusableCell(
      withReuseIdentifier: cellType.reuseIdentifier,
      for: indexPath
    ) as? Cell else {
      fatalError("Cell is not \(Cell.self) type.")
    }
    return cell
  }
}
