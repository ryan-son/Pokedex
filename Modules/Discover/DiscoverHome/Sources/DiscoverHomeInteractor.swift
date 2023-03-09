//
//  DiscoverHomeInteractor.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import RIBs
import RxSwift

protocol DiscoverHomeRouting: ViewableRouting {}

protocol DiscoverHomePresentable: Presentable {
  var listener: DiscoverHomePresentableListener? { get set }
}

public protocol DiscoverHomeListener: AnyObject {}

final class DiscoverHomeInteractor:
  PresentableInteractor<DiscoverHomePresentable>,
  DiscoverHomeInteractable,
  DiscoverHomePresentableListener {

  weak var router: DiscoverHomeRouting?
  weak var listener: DiscoverHomeListener?

  override init(presenter: DiscoverHomePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
  }

  override func willResignActive() {
    super.willResignActive()
  }
}
