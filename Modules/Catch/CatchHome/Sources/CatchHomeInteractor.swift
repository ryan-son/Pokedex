//
//  CatchHomeInteractor.swift
//  CatchHome
//
//  Created by Geonhee on 2023/03/13.
//

import PXUtilities
import RIBs
import RxSwift
import SharedModels

protocol CatchHomeRouting: ViewableRouting {
  func routeToLogin()
}

protocol CatchHomePresentable: Presentable {
  var listener: CatchHomePresentableListener? { get set }

  func layoutLoggedIn()
  func layoutLoggedOut()
}

public protocol CatchHomeListener: AnyObject {}

protocol CatchHomeInteractorDependency {
  var user: ReadOnlyBehaviorSubject<User?> { get }
}

final class CatchHomeInteractor:
  PresentableInteractor<CatchHomePresentable>,
  CatchHomeInteractable,
  CatchHomePresentableListener {

  weak var router: CatchHomeRouting?
  weak var listener: CatchHomeListener?

  private let dependency: CatchHomeInteractorDependency

  private var isLoggedIn: Bool {
    guard let user = dependency.user.value else { return false }
    return user != nil
  }

  init(
    presenter: CatchHomePresentable,
    dependency: CatchHomeInteractorDependency
  ) {
    self.dependency = dependency
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()

    if isLoggedIn {
      presenter.layoutLoggedIn()
    } else {
      presenter.layoutLoggedOut()
    }
  }

  override func willResignActive() {
    super.willResignActive()
  }

  func didTapLoginButton() {
    router?.routeToLogin()
  }

  func didTapStartButton() {

  }
}
