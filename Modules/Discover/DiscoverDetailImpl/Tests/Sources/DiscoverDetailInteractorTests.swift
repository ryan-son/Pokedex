//
//  DiscoverDetailInteractorTests.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

@testable import DiscoverDetailImpl
import RIBsTestSupport
import XCTest

final class DiscoverDetailInteractorTests: XCTestCase {

  private var sut: DiscoverDetailInteractor!

  private var presenter: DiscoverDetailPresentableMock!
  private var listener: DiscoverDetailListenerMock!
  private var router: DiscoverDetailRoutingMock!
  private var viewController: ViewControllableMock!

  override func setUp() {
    super.setUp()

    self.presenter = DiscoverDetailPresentableMock()
    self.listener = DiscoverDetailListenerMock()
    self.viewController = ViewControllableMock()

    let interactor = DiscoverDetailInteractor(presenter: presenter)

    self.router = DiscoverDetailRoutingMock(
      interactable: interactor,
      viewControllable: viewController
    )

    sut = interactor
    sut.listener = listener
    sut.router = router
  }

  // MARK: - Tests

  func test_didtapBackButton() {
    // when
    sut.didTapBackButton()

    // then
    XCTAssertEqual(listener.discoverDetailDidTapBackButtonCallCount, 1)
  }
}
