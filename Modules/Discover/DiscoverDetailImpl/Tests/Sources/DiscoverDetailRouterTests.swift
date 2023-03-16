//
//  DiscoverDetailRouterTests.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

@testable import DiscoverDetailImpl
import XCTest

final class DiscoverDetailRouterTests: XCTestCase {

  private var sut: DiscoverDetailRouter!

  private var interactor: DiscoverDetailInteractableMock!
  private var viewController: DiscoverDetailViewControllableMock!

  override func setUp() {
    super.setUp()

    self.interactor = DiscoverDetailInteractableMock()
    self.viewController = DiscoverDetailViewControllableMock()

    sut = DiscoverDetailRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
