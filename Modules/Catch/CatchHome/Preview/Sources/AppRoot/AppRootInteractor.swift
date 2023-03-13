//
//  AppRootInteractor.swift
//  PokedexApp
//
//  Created by Geonhee on 2023/03/09.
//

import Foundation
import RIBs
import RxSwift

protocol AppRootRouting: Routing {}

protocol AppRootPresentable: Presentable {
  var listener: AppRootPresentableListener? { get set }
}

protocol AppRootListener: AnyObject {}

final class AppRootInteractor:
  PresentableInteractor<AppRootPresentable>,
  AppRootInteractable,
  AppRootPresentableListener,
  URLHandler {

  weak var router: AppRootRouting?
  weak var listener: AppRootListener?

  override init(presenter: AppRootPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
  }

  override func willResignActive() {
    super.willResignActive()
  }

  func handle(_ url: URL) {}
}
