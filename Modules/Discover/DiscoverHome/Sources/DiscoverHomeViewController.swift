//
//  DiscoverHomeViewController.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import RIBs
import RxSwift
import UIKit

protocol DiscoverHomePresentableListener: AnyObject {}

final class DiscoverHomeViewController: UIViewController, DiscoverHomePresentable, DiscoverHomeViewControllable {

  weak var listener: DiscoverHomePresentableListener?

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Discover Home"
    label.textColor = .label
    return label
  }()

  init() {
    super.init(nibName: nil, bundle: nil)
    attribute()
    setupViews()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    attribute()
    setupViews()
  }

  private func attribute() {
    title = "Discover"
    self.view.backgroundColor = .systemGray6
    tabBarItem = UITabBarItem(
      title: "Discover",
      image: UIImage(systemName: "eyes.inverse"),
      selectedImage: UIImage(systemName: "eyes")
    )
  }

  private func setupViews() {
    self.view.addSubview(titleLabel)

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    ])
  }
}
