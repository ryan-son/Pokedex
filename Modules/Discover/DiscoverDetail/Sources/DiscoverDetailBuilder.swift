//
//  DiscoverDetailBuilder.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

import RIBs

public protocol DiscoverDetailDependency: Dependency {}

final class DiscoverDetailComponent: Component<DiscoverDetailDependency> {}

// MARK: - Builder

public protocol DiscoverDetailBuildable: Buildable {
  func build(withListener listener: DiscoverDetailListener) -> ViewableRouting
}

public final class DiscoverDetailBuilder: Builder<DiscoverDetailDependency>, DiscoverDetailBuildable {

  public override init(dependency: DiscoverDetailDependency) {
    super.init(dependency: dependency)
  }

  public func build(withListener listener: DiscoverDetailListener) -> ViewableRouting {
    let component = DiscoverDetailComponent(dependency: dependency)
    let viewController = DiscoverDetailViewController()
    let interactor = DiscoverDetailInteractor(presenter: viewController)
    interactor.listener = listener
    return DiscoverDetailRouter(interactor: interactor, viewController: viewController)
  }
}
