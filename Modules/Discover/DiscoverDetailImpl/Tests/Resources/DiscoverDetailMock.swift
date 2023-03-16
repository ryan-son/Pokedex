@testable import DiscoverDetailImpl
import DiscoverDetail
import RxSwift
import RIBsTestSupport
import UIKit

final class DiscoverDetailPresentableMock: DiscoverDetailPresentable {
  var listener: DiscoverDetailPresentableListener?
}

final class DiscoverDetailListenerMock: DiscoverDetailListener {

  var discoverDetailDidTapBackButtonCallCount = 0
  func discoverDetailDidTapBackButton() {
    discoverDetailDidTapBackButtonCallCount += 1
  }
}

final class DiscoverDetailRoutingMock: ViewableRoutingMock, DiscoverDetailRouting {}

final class DiscoverDetailInteractableMock: InteractableMock, DiscoverDetailInteractable {

  var router: DiscoverDetailRouting?
  var listener: DiscoverDetailListener?
}

final class DiscoverDetailViewControllableMock: UIViewController, DiscoverDetailViewControllable {}
