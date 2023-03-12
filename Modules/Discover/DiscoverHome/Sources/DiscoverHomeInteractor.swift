//
//  DiscoverHomeInteractor.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import PokemonRepository
import RIBs
import RxCocoa
import RxSwift
import SharedModels

protocol DiscoverHomeRouting: ViewableRouting {}

protocol DiscoverHomePresentable: Presentable {
  var listener: DiscoverHomePresentableListener? { get set }

  func updateViews(with pokemons: [Pokemon])
}

public protocol DiscoverHomeListener: AnyObject {}

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

  func fetchNextPage() {
    dependency.pokemonRepository.fetchPokemons(limit: 20)
  }
}
