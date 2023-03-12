//
//  RootTabBarController.swift
//  PokedexApp
//
//  Created by Geonhee on 2023/03/09.
//

import RIBs
import UIKit

protocol AppRootPresentableListener: AnyObject {}

final class RootTabBarController:
  UITabBarController,
  AppRootViewControllable,
  AppRootPresentable {
  weak var listener: AppRootPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
  }

  func setViewControllers(_ viewControllers: [ViewControllable]) {
    super.setViewControllers(viewControllers.map(\.uiviewController), animated: false)
  }

  private func attribute() {
    tabBar.isTranslucent = false
    tabBar.tintColor = .label
    tabBar.backgroundColor = .systemBackground
    addBorder()
  }

  private func addBorder() {
    let topBorder = CALayer()
    topBorder.backgroundColor = UIColor.label.cgColor
    topBorder.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 0.3)
    tabBar.layer.addSublayer(topBorder)
  }
}
