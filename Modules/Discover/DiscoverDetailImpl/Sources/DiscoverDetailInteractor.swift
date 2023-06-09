//
//  DiscoverDetailInteractor.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

import DiscoverDetail
import ImageLoader
import RIBs
import RxSwift

protocol DiscoverDetailRouting: ViewableRouting {}

protocol DiscoverDetailPresentable: Presentable {
  var listener: DiscoverDetailPresentableListener? { get set }
}

protocol DiscoverDetailInteractorDependency {}

final class DiscoverDetailInteractor:
  PresentableInteractor<DiscoverDetailPresentable>,
  DiscoverDetailInteractable,
  DiscoverDetailPresentableListener {

  weak var router: DiscoverDetailRouting?
  weak var listener: DiscoverDetailListener?

  override init(
    presenter: DiscoverDetailPresentable
  ) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
  }

  override func willResignActive() {
    super.willResignActive()
  }

  func didTapBackButton() {
    listener?.discoverDetailDidTapBackButton()
  }
}
