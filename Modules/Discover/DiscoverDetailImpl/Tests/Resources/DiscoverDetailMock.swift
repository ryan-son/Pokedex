@testable import DiscoverDetailImpl
import DiscoverDetail

final class DiscoverDetailPresentableMock: DiscoverDetailPresentable {
  var listener: DiscoverDetailPresentableListener?
}

final class DiscoverDetailListenerMock: DiscoverDetailListener {

  var discoverDetailDidTapBackButtonCallCount = 0
  func discoverDetailDidTapBackButton() {
    discoverDetailDidTapBackButtonCallCount += 1
  }
}
