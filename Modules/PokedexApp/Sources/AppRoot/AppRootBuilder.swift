//
//  AppRootBuilder.swift
//  PokedexApp
//
//  Created by Geonhee on 2023/03/09.
//

import DiscoverHome
import RIBs

protocol AppRootDependency: Dependency {}

final class AppRootComponent: Component<AppRootDependency>, DiscoverHomeDependency {

  private let rootViewController: ViewControllable

  init(
    dependency: AppRootDependency,
    rootViewController: ViewControllable
  ) {
    self.rootViewController = rootViewController
    super.init(dependency: dependency)
  }
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
  func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler)
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {

  override init(dependency: AppRootDependency) {
    super.init(dependency: dependency)
  }

  func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler) {
    let tabBarViewController = RootTabBarController()
    let component = AppRootComponent(
      dependency: dependency,
      rootViewController: tabBarViewController
    )
    let interactor = AppRootInteractor(presenter: tabBarViewController)

    let discoverHomeBuilder = DiscoverHomeBuilder(dependency: component)
    let router = AppRootRouter(
      interactor: interactor,
      viewController: tabBarViewController,
      discoverHomeBuilder: discoverHomeBuilder
    )

    return (router, interactor)
  }
}
