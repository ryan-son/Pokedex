//
//  DiscoverHomeInteractorTests.swift
//  DiscoverHomeImplTests
//
//  Created by Geonhee on 2023/03/16.
//

@testable import DiscoverHomeImpl
import DiscoverHome
import PokemonRepository
import PokemonRepositoryTestSupport
import RIBsTestSupport
import XCTest

final class DiscoverHomeInteractorTests: XCTestCase {

  private var sut: DiscoverHomeInteractor!

  private var presenter: DiscoverHomePresentableMock!
  private var dependency: DiscoverHomeInteractorDependencyMock!
  private var listener: DiscoverHomeListenerMock!
  private var router: DiscoverHomeRoutingMock!
  private var viewController: ViewControllableMock!

  private var repository: PokemonRepositoryMock {
    return dependency.pokemonRepository as! PokemonRepositoryMock
  }

  override func setUp() {
    super.setUp()

    self.presenter = DiscoverHomePresentableMock()
    self.dependency = DiscoverHomeInteractorDependencyMock()
    self.listener = DiscoverHomeListenerMock()
    self.viewController = ViewControllableMock()

    let interactor = DiscoverHomeInteractor(
      presenter: presenter,
      dependency: dependency
    )
    let router = DiscoverHomeRoutingMock(
      interactable: interactor,
      viewControllable: viewController
    )
    self.router = router

    interactor.listener = listener
    interactor.router = router

    sut = interactor
  }

  // MARK: - Tests

  func testActivate() {
    // when
    sut.activate()

    // then
    XCTAssertEqual(repository.fetchPokemonsCallCount, 1)
    XCTAssertEqual(repository.fetchPokemonsLimit, 20)
    XCTAssertEqual(repository.pokemons.value?.first?.id, "0")
    XCTAssertEqual(repository.pokemons.value?.first?.name, "Squirtle")
    XCTAssertEqual(repository.pokemons.value?.count, 20)
  }

  func testFetchNextPageAfterActivate() {
    // when
    sut.activate()
    sut.fetchNextPage()

    // then
    XCTAssertEqual(repository.fetchPokemonsCallCount, 2)
    XCTAssertEqual(repository.fetchPokemonsLimit, 20)
    XCTAssertEqual(repository.pokemons.value?.first?.id, "0")
    XCTAssertEqual(repository.pokemons.value?.first?.name, "Squirtle")
    XCTAssertEqual(repository.pokemons.value?.count, 20)
  }

  func testDidTapPokemonAtFirstItem() {
    // when
    sut.activate()
    sut.didTapPokemon(at: 0)

    // then
    XCTAssertEqual(router.routeToDiscoverDetailCallCount, 1)
    XCTAssertEqual(router.routeToDiscoverDetailSelectedPokemon?.id, "0")
    XCTAssertEqual(router.routeToDiscoverDetailSelectedPokemon?.name, "Squirtle")
  }

  func testDiscoverDetailDidTapBackButton() {
    // when
    sut.discoverDetailDidTapBackButton()

    // then
    XCTAssertEqual(router.detachDiscoverDetailCallCount, 1)
  }
}
