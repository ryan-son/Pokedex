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

    tabBar.isTranslucent = false
    tabBar.tintColor = .black
    tabBar.backgroundColor = .systemBackground
  }

  func setViewControllers(_ viewControllers: [ViewControllable]) {
    super.setViewControllers(viewControllers.map(\.uiviewController), animated: false)
  }
}
