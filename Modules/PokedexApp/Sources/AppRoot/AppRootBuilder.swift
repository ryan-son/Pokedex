//
//  AppRootBuilder.swift
//  PokedexApp
//
//  Created by Geonhee on 2023/03/09.
//

import CatchHome
import PokemonRepository
import ImageLoader
import DiscoverHome
import PXUtilities
import RIBs
import RxSwift
import SharedModels

protocol AppRootDependency: Dependency {
  var pokemonRepository: PokemonRepository { get }
  var imageLoader: ImageLoader { get }
  var userSubject: BehaviorSubject<User?> { get }
}

final class AppRootComponent:
  Component<AppRootDependency>,
  AppRootInteractorDependency,
  DiscoverHomeDependency,
  CatchHomeDependency {

  private let rootViewController: ViewControllable
  var pokemonRepository: PokemonRepository { dependency.pokemonRepository }
  var imageLoader: ImageLoader { dependency.imageLoader }

  var userSubject: BehaviorSubject<User?> { dependency.userSubject }
  var user: ReadOnlyBehaviorSubject<User?> { ReadOnlyBehaviorSubject(for: dependency.userSubject) }

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

    let discoverHomeBuilder = DiscoverHomeBuilder(dependency: component)
    let catchHomeBuilder = CatchHomeBuilder(dependency: component)

    let router = AppRootRouter(
      interactor: interactor,
      viewController: tabBarViewController,
      imageLoader: component.imageLoader,
      discoverHomeBuilder: discoverHomeBuilder,
      catchHomeBuilder: catchHomeBuilder
    )

    return (router, interactor)
  }
}
