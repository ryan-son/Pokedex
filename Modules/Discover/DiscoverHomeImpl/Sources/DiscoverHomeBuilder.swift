//
//  DiscoverHomeBuilder.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import DiscoverHome
import DiscoverDetail
import ImageLoader
import PokemonRepository
import PXUtilities
import RIBs
import RxSwift
import SharedModels

import Foundation

final class DiscoverHomeComponent:
  Component<DiscoverHomeDependency>,
  DiscoverHomeInteractorDependency,
  DiscoverDetailDependency {
  fileprivate var discoverDetailBuilder: DiscoverDetailBuildable { dependency.discoverDetailBuilder }
  var pokemonRepository: PokemonRepository { dependency.pokemonRepository }
  var mainQueue: ImmediateSchedulerType { dependency.mainQueue }
  var pokemons: ReadOnlyBehaviorSubject<[Pokemon]> { dependency.pokemonRepository.pokemons }
  var imageLoader: ImageLoader { dependency.imageLoader }
  var user: ReadOnlyBehaviorSubject<User?> { dependency.user }

  override init(
    dependency: DiscoverHomeDependency
  ) {
    super.init(dependency: dependency)
  }
}

// MARK: - Builder

public final class DiscoverHomeBuilder: Builder<DiscoverHomeDependency>, DiscoverHomeBuildable {

  public override init(dependency: DiscoverHomeDependency) {
    super.init(dependency: dependency)
  }

  public func build(
    withListener listener: DiscoverHomeListener
  ) -> ViewableRouting {
    let component = DiscoverHomeComponent(dependency: dependency)
    let viewController = DiscoverHomeViewController(imageLoader: dependency.imageLoader)
    let interactor = DiscoverHomeInteractor(
      presenter: viewController,
      dependency: component
    )
    interactor.listener = listener

    return DiscoverHomeRouter(
      interactor: interactor,
      viewController: viewController,
      discoverDetailBuilder: component.discoverDetailBuilder
    )
  }
}
