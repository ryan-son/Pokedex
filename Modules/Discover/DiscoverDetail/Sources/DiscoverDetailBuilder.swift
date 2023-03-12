//
//  DiscoverDetailBuilder.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

import RIBs

protocol DiscoverDetailDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

final class DiscoverDetailComponent: Component<DiscoverDetailDependency> {
  
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DiscoverDetailBuildable: Buildable {
  func build(withListener listener: DiscoverDetailListener) -> DiscoverDetailRouting
}

final class DiscoverDetailBuilder: Builder<DiscoverDetailDependency>, DiscoverDetailBuildable {
  
  override init(dependency: DiscoverDetailDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: DiscoverDetailListener) -> DiscoverDetailRouting {
    let component = DiscoverDetailComponent(dependency: dependency)
    let viewController = DiscoverDetailViewController()
    let interactor = DiscoverDetailInteractor(presenter: viewController)
    interactor.listener = listener
    return DiscoverDetailRouter(interactor: interactor, viewController: viewController)
  }
}
