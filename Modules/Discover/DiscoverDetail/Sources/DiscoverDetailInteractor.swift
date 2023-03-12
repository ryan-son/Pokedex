//
//  DiscoverDetailInteractor.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

import RIBs
import RxSwift

protocol DiscoverDetailRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DiscoverDetailPresentable: Presentable {
  var listener: DiscoverDetailPresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol DiscoverDetailListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class DiscoverDetailInteractor: PresentableInteractor<DiscoverDetailPresentable>, DiscoverDetailInteractable, DiscoverDetailPresentableListener {

  weak var router: DiscoverDetailRouting?
  weak var listener: DiscoverDetailListener?

  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: DiscoverDetailPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: Implement business logic here.
  }

  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
}
