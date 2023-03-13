//
//  CatchHomeBuilder.swift
//  CatchHome
//
//  Created by Geonhee on 2023/03/13.
//

import PXUtilities
import RIBs
import SharedModels

public protocol CatchHomeDependency: Dependency {
  var user: ReadOnlyBehaviorSubject<User?> { get }
}

final class CatchHomeComponent: Component<CatchHomeDependency>, CatchHomeInteractorDependency {
  var user: ReadOnlyBehaviorSubject<User?> { dependency.user }
}

// MARK: - Builder

public protocol CatchHomeBuildable: Buildable {
  func build(withListener listener: CatchHomeListener) -> ViewableRouting
}

public final class CatchHomeBuilder: Builder<CatchHomeDependency>, CatchHomeBuildable {

  public override init(dependency: CatchHomeDependency) {
    super.init(dependency: dependency)
  }

  public func build(withListener listener: CatchHomeListener) -> ViewableRouting {
    let component = CatchHomeComponent(dependency: dependency)
    let viewController = CatchHomeViewController()
    let interactor = CatchHomeInteractor(
      presenter: viewController,
      dependency: component
    )
    interactor.listener = listener
    return CatchHomeRouter(interactor: interactor, viewController: viewController)
  }
}
