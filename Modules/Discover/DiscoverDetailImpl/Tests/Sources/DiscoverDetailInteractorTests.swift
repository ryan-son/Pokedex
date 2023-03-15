//
//  DiscoverDetailInteractorTests.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

@testable import DiscoverDetailImpl
import XCTest

final class DiscoverDetailInteractorTests: XCTestCase {

  private var sut: DiscoverDetailInteractor!

  private var presenter: DiscoverDetailPresentableMock!
  private var listener: DiscoverDetailListenerMock!

  override func setUp() {
    super.setUp()

    self.presenter = DiscoverDetailPresentableMock()
    self.listener = DiscoverDetailListenerMock()

    sut = DiscoverDetailInteractor(presenter: presenter)
    sut.listener = listener
  }

  // MARK: - Tests

  func test_exampleObservable_callsRouterOrListener_exampleProtocol() {
  }
}
