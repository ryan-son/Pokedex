//
//  CatchHomeBuilder.swift
//  CatchHome
//
//  Created by Geonhee on 2023/03/13.
//

import ImageLoader
import Login
import PokemonRepository
import PXUtilities
import RIBs
import SharedModels

public protocol CatchHomeDependency: Dependency {
  var pokemonRepository: PokemonRepository { get }
  var imageLoader: ImageLoader { get }
  var user: ReadOnlyBehaviorSubject<User?> { get }
}

final class CatchHomeComponent:
  Component<CatchHomeDependency>,
  CatchHomeInteractorDependency,
  LoginDependency {
  var pokemonRepository: PokemonRepository { dependency.pokemonRepository }
  var imageLoader: ImageLoader { dependency.imageLoader }
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
    let viewController = CatchHomeViewController(imageLoader: component.imageLoader)
    let interactor = CatchHomeInteractor(
      presenter: viewController,
      dependency: component
    )
    interactor.listener = listener

    let loginBuilder = LoginBuilder(dependency: component)

    return CatchHomeRouter(
      interactor: interactor,
      viewController: viewController,
      loginBuilder: loginBuilder
    )
  }
}
