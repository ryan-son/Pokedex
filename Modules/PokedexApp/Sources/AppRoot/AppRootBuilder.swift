//
//  AppRootBuilder.swift
//  PokedexApp
//
//  Created by Geonhee on 2023/03/09.
//

import CatchHome
import DiscoverDetail
import DiscoverHome
import ImageLoader
import Login
import PokemonRepository
import PXUtilities
import RIBs
import RxSwift
import SharedModels

protocol AppRootDependency: Dependency {
  var catchHomeBuilder: CatchHomeBuildable { get }
  var discoverHomeBuilder: DiscoverHomeBuildable { get }
  var discoverDetailBuilder: DiscoverDetailBuildable { get }
  var loginBuilder: LoginBuildable { get }

  var pokemonRepository: PokemonRepository { get }
  var mainQueue: ImmediateSchedulerType { get }
  var imageLoader: ImageLoader { get }
  var userSubject: BehaviorSubject<User?> { get }
  var user: ReadOnlyBehaviorSubject<User?> { get }
}

final class AppRootComponent:
  Component<AppRootDependency>,
  AppRootInteractorDependency,
  DiscoverHomeDependency,
  CatchHomeDependency {
  var catchHomeBuilder: CatchHomeBuildable { dependency.catchHomeBuilder }
  var discoverHomeBuilder: DiscoverHomeBuildable { dependency.discoverHomeBuilder }
  var discoverDetailBuilder: DiscoverDetailBuildable { dependency.discoverDetailBuilder }
  var loginBuilder: LoginBuildable { dependency.loginBuilder }

  private let rootViewController: ViewControllable
  var mainQueue: ImmediateSchedulerType { dependency.mainQueue }
  var pokemonRepository: PokemonRepository { dependency.pokemonRepository }
  var imageLoader: ImageLoader { dependency.imageLoader }

  var userSubject: BehaviorSubject<User?> { dependency.userSubject }
  var user: ReadOnlyBehaviorSubject<User?> { dependency.user }

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
    let interactor = AppRootInteractor(
      presenter: tabBarViewController,
      dependency: component
    )

    let router = AppRootRouter(
      interactor: interactor,
      viewController: tabBarViewController,
      imageLoader: component.imageLoader,
      discoverHomeBuilder: component.discoverHomeBuilder,
      catchHomeBuilder: component.catchHomeBuilder
    )

    return (router, interactor)
  }
}
