//
//  AppRootInteractor.swift
//  PokedexApp
//
//  Created by Geonhee on 2023/03/09.
//

import CatchHome
import Foundation
import RIBs
import RxSwift
import SharedModels

protocol AppRootRouting: Routing {
  func attachTaps()
}

protocol AppRootPresentable: Presentable {
  var listener: AppRootPresentableListener? { get set }
}

protocol AppRootListener: AnyObject {}

protocol AppRootInteractorDependency {
  var userSubject: BehaviorSubject<User?> { get }
}

final class AppRootInteractor:
  PresentableInteractor<AppRootPresentable>,
  AppRootInteractable,
  AppRootPresentableListener,
  CatchHomeListener,
  URLHandler {

  weak var router: AppRootRouting?
  weak var listener: AppRootListener?

  private let dependency: AppRootInteractorDependency

  init(
    presenter: AppRootPresentable,
    dependency: AppRootInteractorDependency
  ) {
    self.dependency = dependency
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
    router?.attachTaps()
  }

  override func willResignActive() {
    super.willResignActive()
  }

  func loginDidTapLoginButton(with user: User) {
    dependency.userSubject.onNext(user)
  }

  func handle(_ url: URL) {}
}
