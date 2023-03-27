//
//  CatchHomeRouterTests.swift
//  CatchHomeTests
//
//  Created by Geonhee on 2023/03/15.
//

@testable import CatchHomeImpl
import Login
import RIBs
import RIBsTestSupport
import XCTest

final class CatchHomeRouterTests: XCTestCase {

  private var sut: CatchHomeRouter!
  private var interactor: CatchHomeInteractableMock!
  private var viewController: CatchHomeViewControllableMock!
  private var loginBuilder: LoginBuildableMock!

  override func setUp() {
    super.setUp()

    let interactor = CatchHomeInteractableMock()
    let viewController = CatchHomeViewControllableMock()
    let loginBuilder = LoginBuildableMock()

    self.interactor = interactor
    self.viewController = viewController
    self.loginBuilder = loginBuilder

    sut = CatchHomeRouter(
      interactor: interactor,
      viewController: viewController,
      loginBuilder: loginBuilder
    )
  }

  // MARK: - Tests

  func test_routeToLogin() {
    // given
    let router = LoginRoutingMock(
      interactable: Interactor(),
      viewControllable: ViewControllableMock()
    )
    var assignedListener: LoginListener?
    loginBuilder.buildHandler = { listener in
      assignedListener = listener
      return router
    }

    // when
    sut.routeToLogin()

    // then
    XCTAssertTrue(assignedListener === interactor)
    XCTAssertEqual(loginBuilder.buildCallCount, 1)
    XCTAssertEqual(viewController.presentCallCount, 1)
  }

  func test_detachLogin() {
    // given
    let loginViewController = ViewControllableMock()
    let router = LoginRoutingMock(
      interactable: Interactor(),
      viewControllable: loginViewController
    )
    loginBuilder.buildHandler = { _ in router }
    sut.routeToLogin()

    // when
    sut.detachLogin()

    // then
    XCTAssertEqual(loginViewController.dismissCallCount, 1)
  }
}
