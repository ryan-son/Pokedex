//
//  DiscoverHomeBuilder.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import APIServiceImpl
import PokemonRepository
import RIBs
import RIBsUtil
import RxSwift

public protocol DiscoverHomeDependency: Dependency {}

final class DiscoverHomeComponent: Component<DiscoverHomeDependency>, DiscoverHomeInteractorDependency {
  private let pokemonRepository: PokemonRepository
  var pokemons: Observable<[Pokemon]> { pokemonRepository.pokemons }

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
  func build(withListener listener: DiscoverHomeListener) -> ViewableRouting
}

public final class DiscoverHomeBuilder: Builder<DiscoverHomeDependency>, DiscoverHomeBuildable {

  public override init(dependency: DiscoverHomeDependency) {
    super.init(dependency: dependency)
  }

  public func build(withListener listener: DiscoverHomeListener) -> ViewableRouting {
    let pokemonRepository = PokemonRepositoryImpl(
      apiService: APIServiceImpl(session: .shared),
      baseURL: BaseURL.pokemon
    )
    pokemonRepository.fetchPokemons()

    let component = DiscoverHomeComponent(
      dependency: dependency,
      pokemonRepository: pokemonRepository
    )
    let viewController = DiscoverHomeViewController()
    let interactor = DiscoverHomeInteractor(
      presenter: viewController,
      dependency: component
    )
    interactor.listener = listener
    return DiscoverHomeRouter(interactor: interactor, viewController: viewController)
  }
}
