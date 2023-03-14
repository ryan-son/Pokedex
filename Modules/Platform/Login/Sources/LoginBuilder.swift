//
//  LoginBuilder.swift
//  Login
//
//  Created by Geonhee on 2023/03/13.
//

import PXUtilities
import RIBs
import SharedModels

public protocol LoginDependency: Dependency {
  var user: ReadOnlyBehaviorSubject<User?> { get }
}

final class LoginComponent: Component<LoginDependency>, LoginInteractorDependency {
  var user: ReadOnlyBehaviorSubject<User?> { dependency.user }
}

// MARK: - Builder

public protocol LoginBuildable: Buildable {
  func build(withListener listener: LoginListener) -> ViewableRouting
}

public final class LoginBuilder: Builder<LoginDependency>, LoginBuildable {

  public override init(dependency: LoginDependency) {
    super.init(dependency: dependency)
  }

  public func build(withListener listener: LoginListener) -> ViewableRouting {
    let component = LoginComponent(dependency: dependency)
    let viewController = LoginViewController()
    let interactor = LoginInteractor(
      presenter: viewController,
      dependency: component
    )
    interactor.listener = listener
    return LoginRouter(interactor: interactor, viewController: viewController)
  }
}
