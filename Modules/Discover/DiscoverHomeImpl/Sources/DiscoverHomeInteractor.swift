//
//  DiscoverHomeInteractor.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import DiscoverHome
import PokemonRepository
import PXUtilities
import RIBs
import RxCocoa
import RxSwift
import SharedModels

protocol DiscoverHomeRouting: ViewableRouting {
  func routeToDiscoverDetail(selectedPokemon: Pokemon)
  func detachDiscoverDetail()
}

protocol DiscoverHomePresentable: Presentable {
  var listener: DiscoverHomePresentableListener? { get set }

  func updateViews(with pokemons: [Pokemon])
}

protocol DiscoverHomeInteractorDependency {
  var pokemonRepository: PokemonRepository { get }
}

final class DiscoverHomeInteractor:
  PresentableInteractor<DiscoverHomePresentable>,
  DiscoverHomeInteractable,
  DiscoverHomePresentableListener {

  weak var router: DiscoverHomeRouting?
  weak var listener: DiscoverHomeListener?

  private let dependency: DiscoverHomeInteractorDependency

  private var pokemons: [Pokemon] {
    return dependency.pokemonRepository.pokemons.value ?? []
  }

  init(
    presenter: DiscoverHomePresentable,
    dependency: DiscoverHomeInteractorDependency
  ) {
    self.dependency = dependency
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()

    fetchNextPage()

    dependency.pokemonRepository.pokemons
      .asDriver(onErrorJustReturn: [])
      .drive(onNext: { [weak self] pokemons in
        self?.presenter.updateViews(with: pokemons)
      })
      .disposeOnDeactivate(interactor: self)
  }

  override func willResignActive() {
    super.willResignActive()
  }

  // MARK: - DiscoverHomePresentableListener

  func fetchNextPage() {
    dependency.pokemonRepository.fetchPokemons(limit: 20)
  }

  func didTapPokemon(at item: Int) {
    router?.routeToDiscoverDetail(selectedPokemon: pokemons[item])
  }

  // MARK: - DiscoverDetailListener

  func discoverDetailDidTapBackButton() {
    router?.detachDiscoverDetail()
  }
}
