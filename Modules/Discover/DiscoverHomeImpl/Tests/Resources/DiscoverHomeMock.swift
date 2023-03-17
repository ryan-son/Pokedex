@testable import DiscoverHomeImpl
import DiscoverHome
import PokemonRepository
import PokemonRepositoryTestSupport
import RxSwift
import RIBsTestSupport
import SharedModels

final class DiscoverHomePresentableMock: DiscoverHomePresentable {
  var listener: DiscoverHomePresentableListener?

  var updateViewsCallCount = 0
  var updateViewsPokemons: [Pokemon]?
  func updateViews(with pokemons: [Pokemon]) {
    updateViewsCallCount += 1
    updateViewsPokemons = pokemons
  }
}

final class DiscoverHomeInteractorDependencyMock: DiscoverHomeInteractorDependency {

  var mainQueue: ImmediateSchedulerType { CurrentThreadScheduler.instance }
  var pokemonRepository: PokemonRepository = PokemonRepositoryMock()
}

final class DiscoverHomeListenerMock: DiscoverHomeListener {}

final class DiscoverHomeRoutingMock: ViewableRoutingMock, DiscoverHomeRouting {

  var routeToDiscoverDetailCallCount = 0
  var routeToDiscoverDetailSelectedPokemon: Pokemon?
  func routeToDiscoverDetail(selectedPokemon: Pokemon) {
    routeToDiscoverDetailCallCount += 1
    routeToDiscoverDetailSelectedPokemon = selectedPokemon
  }

  var detachDiscoverDetailCallCount = 0
  func detachDiscoverDetail() {
    detachDiscoverDetailCallCount += 1
  }
}
