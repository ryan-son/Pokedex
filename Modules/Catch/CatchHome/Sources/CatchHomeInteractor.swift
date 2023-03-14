//
//  CatchHomeInteractor.swift
//  CatchHome
//
//  Created by Geonhee on 2023/03/13.
//

import PokemonRepository
import PXUtilities
import RIBs
import RxSwift
import SharedModels

protocol CatchHomeRouting: ViewableRouting {
  func routeToLogin()
  func detachLogin()
}

protocol CatchHomePresentable: Presentable {
  var listener: CatchHomePresentableListener? { get set }

  func layoutLoggedIn()
  func layoutLoggedOut()
  func updatePokemonCardView(with pokemon: Pokemon)
}

public protocol CatchHomeListener: AnyObject {
  func loginDidTapLoginButton(with user: User)
}

protocol CatchHomeInteractorDependency {
  var pokemonRepository: PokemonRepository { get }
  var user: ReadOnlyBehaviorSubject<User?> { get }
}

final class CatchHomeInteractor:
  PresentableInteractor<CatchHomePresentable>,
  CatchHomeInteractable,
  CatchHomePresentableListener {

  weak var router: CatchHomeRouting?
  weak var listener: CatchHomeListener?

  private let dependency: CatchHomeInteractorDependency

  private var isLoggedIn: Bool {
    guard let user = dependency.user.value else { return false }
    return user != nil
  }

  init(
    presenter: CatchHomePresentable,
    dependency: CatchHomeInteractorDependency
  ) {
    self.dependency = dependency
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()

    dependency.user
      .compactMap { $0 }
      .subscribe(onNext: { [weak self] _ in
        self?.presenter.layoutLoggedIn()
        self?.setRandomPokemon()
      })
      .disposeOnDeactivate(interactor: self)

    if isLoggedIn {
      presenter.layoutLoggedIn()
      setRandomPokemon()
    } else {
      presenter.layoutLoggedOut()
    }
  }

  override func willResignActive() {
    super.willResignActive()
  }

  private func setRandomPokemon() {
    guard let randomPokemon = dependency.pokemonRepository.randomPokemon() else { return }
    presenter.updatePokemonCardView(with: randomPokemon)
  }

  func didTapLoginButton() {
    router?.routeToLogin()
  }

  func didTapCatchButton() {

  }

  func loginDidTapLoginButton(with user: User) {
    listener?.loginDidTapLoginButton(with: user)
    router?.detachLogin()
  }
}
