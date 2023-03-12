//
//  DiscoverHomeBuilder.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import APIService
import ImageLoader
import PokemonRepository
import RIBs
import RIBsUtil
import RxSwift

public protocol DiscoverHomeDependency: Dependency {
  var pokemonRepository: PokemonRepository { get }
  var imageLoader: ImageLoader { get }
}

final class DiscoverHomeComponent: Component<DiscoverHomeDependency>, DiscoverHomeInteractorDependency {
  private let pokemonRepository: PokemonRepository
  var pokemons: Observable<[Pokemon]> { pokemonRepository.pokemons }
  var imageLoader: ImageLoader { dependency.imageLoader }

  init(
    dependency: DiscoverHomeDependency,
    pokemonRepository: PokemonRepository
  ) {
    self.pokemonRepository = pokemonRepository
    super.init(dependency: dependency)
  }
}

// MARK: - Builder

public protocol DiscoverHomeBuildable: Buildable {
  func build(
    withListener listener: DiscoverHomeListener
  ) -> ViewableRouting
}

public final class DiscoverHomeBuilder: Builder<DiscoverHomeDependency>, DiscoverHomeBuildable {

  public override init(dependency: DiscoverHomeDependency) {
    super.init(dependency: dependency)
  }

  public func build(
    withListener listener: DiscoverHomeListener
  ) -> ViewableRouting {
    dependency.pokemonRepository.fetchPokemons()

    let component = DiscoverHomeComponent(
      dependency: dependency,
      pokemonRepository: dependency.pokemonRepository
    )
    let viewController = DiscoverHomeViewController(imageLoader: dependency.imageLoader)
    let interactor = DiscoverHomeInteractor(
      presenter: viewController,
      dependency: component
    )
    interactor.listener = listener
    return DiscoverHomeRouter(interactor: interactor, viewController: viewController)
  }
}
