//
//  DiscoverHomeBuilder.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import RIBs

protocol DiscoverHomeDependency: Dependency {}

final class DiscoverHomeComponent: Component<DiscoverHomeDependency> {}

// MARK: - Builder

protocol DiscoverHomeBuildable: Buildable {
  func build(withListener listener: DiscoverHomeListener) -> DiscoverHomeRouting
}

final class DiscoverHomeBuilder: Builder<DiscoverHomeDependency>, DiscoverHomeBuildable {

  override init(dependency: DiscoverHomeDependency) {
    super.init(dependency: dependency)
  }

  func build(withListener listener: DiscoverHomeListener) -> DiscoverHomeRouting {
    let component = DiscoverHomeComponent(dependency: dependency)
    let viewController = DiscoverHomeViewController()
    let interactor = DiscoverHomeInteractor(presenter: viewController)
    interactor.listener = listener
    return DiscoverHomeRouter(interactor: interactor, viewController: viewController)
  }
}
