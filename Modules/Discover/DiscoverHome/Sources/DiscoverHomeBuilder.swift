//
//  DiscoverHomeBuilder.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import RIBs
import RIBsUtil

public protocol DiscoverHomeDependency: Dependency {}

final class DiscoverHomeComponent: Component<DiscoverHomeDependency> {}

// MARK: - Builder

public protocol DiscoverHomeBuildable: Buildable {
  func build(withListener listener: DiscoverHomeListener) -> ViewableRouting
}

public final class DiscoverHomeBuilder: Builder<DiscoverHomeDependency>, DiscoverHomeBuildable {

  public override init(dependency: DiscoverHomeDependency) {
    super.init(dependency: dependency)
  }

  public func build(withListener listener: DiscoverHomeListener) -> ViewableRouting {
    let component = DiscoverHomeComponent(dependency: dependency)
    let viewController = DiscoverHomeViewController()
    let interactor = DiscoverHomeInteractor(presenter: viewController)
    interactor.listener = listener
    return DiscoverHomeRouter(interactor: interactor, viewController: viewController)
  }
}
