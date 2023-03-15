//
//  CatchHomeBuilder.swift
//  CatchHome
//
//  Created by Geonhee on 2023/03/13.
//

import CatchHome
import ImageLoader
import Login
import PokemonRepository
import PXUtilities
import RIBs
import SharedModels

final class CatchHomeComponent:
  Component<CatchHomeDependency>,
  CatchHomeInteractorDependency,
  LoginDependency {
  var loginBuilder: LoginBuildable { dependency.loginBuilder }
  var pokemonRepository: PokemonRepository { dependency.pokemonRepository }
  var imageLoader: ImageLoader { dependency.imageLoader }
  var user: ReadOnlyBehaviorSubject<User?> { dependency.user }
}

// MARK: - Builder

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

    return CatchHomeRouter(
      interactor: interactor,
      viewController: viewController,
      loginBuilder: component.loginBuilder
    )
  }
}
