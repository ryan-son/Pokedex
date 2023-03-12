//
//  DiscoverDetailViewController.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

import RIBs
import RxSwift
import UIKit

protocol DiscoverDetailPresentableListener: AnyObject {
  func didTapBackButton()
}

final class DiscoverDetailViewController:
  UIViewController,
  DiscoverDetailPresentable,
  DiscoverDetailViewControllable {

  weak var listener: DiscoverDetailPresentableListener?

  init() {
    super.init(nibName: nil, bundle: nil)
    attribute()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented.")
  }

  private func attribute() {
    self.view.backgroundColor = .systemBackground
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(
        systemName: "chevron.backward",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
      ),
      style: .plain,
      target: self,
      action: #selector(didTapBackButton)
    )
  }

  @objc
  private func didTapBackButton() {
    listener?.didTapBackButton()
  }
}
