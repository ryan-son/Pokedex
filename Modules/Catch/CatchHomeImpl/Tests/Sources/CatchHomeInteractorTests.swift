//
//  CatchHomeInteractorTests.swift
//  CatchHomeTests
//
//  Created by Geonhee on 2023/03/15.
//

@testable import CatchHomeImpl
import CatchHome
import PokemonRepositoryTestSupport
import XCTest

final class CatchHomeInteractorTests: XCTestCase {

  private var sut: CatchHomeInteractor!
  private var presenter: CatchHomePresentableMock!
  private var repository: PokemonRepositoryMock!
  private var dependency: CatchHomeInteractorDependencyMock!
  private var listener: CatchHomeListenerMock!
  private var router: CatchHomeRoutingMock!
  private var viewController: CatchHomeViewControllableMock!

  override func setUp() {
    super.setUp()

    let presenter = CatchHomePresentableMock()
    let repository = PokemonRepositoryMock()
    let dependency = CatchHomeInteractorDependencyMock(pokemonRepository: repository)
    let listener = CatchHomeListenerMock()
    let interactor = CatchHomeInteractor(
      presenter: presenter,
      dependency: dependency
    )
    let viewController = CatchHomeViewControllableMock()
    let router = CatchHomeRoutingMock(
      interactable: interactor,
      viewControllable: viewController
    )

    self.presenter = presenter
    self.repository = repository
    self.dependency = dependency
    self.listener = listener
    self.router = router
    self.viewController = viewController

    sut = interactor
    sut.listener = listener
    sut.router = router
  }

  // MARK: - Tests

  func test_exampleObservable_callsRouterOrListener_exampleProtocol() {
  }
}
