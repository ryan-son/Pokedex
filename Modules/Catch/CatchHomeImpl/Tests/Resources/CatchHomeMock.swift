@testable import CatchHomeImpl
import CatchHome
import PokemonRepository
import PokemonRepositoryTestSupport
import PXUtilities
import RxSwift
import RIBsTestSupport
import SharedModels
import UIKit

final class CatchHomePresentableMock: CatchHomePresentable {

  var listener: CatchHomePresentableListener?

  var layoutLoggedInCallCount = 0
  func layoutLoggedIn() {
    layoutLoggedInCallCount += 1
  }

  var layoutLoggedOutCallCount = 0
  func layoutLoggedOut() {
    layoutLoggedOutCallCount += 1
  }

  var updatePokemonCardViewCallCount = 0
  var updatePokemonCardViewPokemon: Pokemon?
  func updatePokemonCardView(with pokemon: Pokemon) {
    updatePokemonCardViewCallCount += 1
    updatePokemonCardViewPokemon = pokemon
  }
}

final class CatchHomeInteractorDependencyMock: CatchHomeInteractorDependency {
  let pokemonRepository: PokemonRepository

  private let userSubject = BehaviorSubject<User?>(value: nil)
  var user: ReadOnlyBehaviorSubject<User?> { ReadOnlyBehaviorSubject(for: userSubject) }

  init(pokemonRepository: PokemonRepository) {
    self.pokemonRepository = pokemonRepository
  }
}

final class CatchHomeListenerMock: CatchHomeListener {

  var loginDidTapLoginButtonCallCount = 0
  var loginDidTapLoginButtonUser: User?
  func loginDidTapLoginButton(with user: User) {
    loginDidTapLoginButtonCallCount += 1
    loginDidTapLoginButtonUser = user
  }
}

final class CatchHomeRoutingMock: ViewableRoutingMock, CatchHomeRouting {

  var routeToLoginCallCount = 0
  func routeToLogin() {
    routeToLoginCallCount += 1
  }

  var detachLoginCallCount = 0
  func detachLogin() {
    detachLoginCallCount += 1
  }
}

final class CatchHomeViewControllableMock: ViewControllableMock, CatchHomeViewControllable {}
