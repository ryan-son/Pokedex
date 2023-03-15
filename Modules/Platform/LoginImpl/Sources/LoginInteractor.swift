//
//  LoginInteractor.swift
//  Login
//
//  Created by Geonhee on 2023/03/13.
//

import Login
import PXUtilities
import RIBs
import RxSwift
import SharedModels

protocol LoginRouting: ViewableRouting {
}

protocol LoginPresentable: Presentable {
  var listener: LoginPresentableListener? { get set }
}

protocol LoginInteractorDependency {
  var user: ReadOnlyBehaviorSubject<User?> { get }
}

final class LoginInteractor:
  PresentableInteractor<LoginPresentable>,
  LoginInteractable,
  LoginPresentableListener {

  weak var router: LoginRouting?
  weak var listener: LoginListener?

  private let dependency: LoginInteractorDependency

  init(
    presenter: LoginPresentable,
    dependency: LoginInteractorDependency
  ) {
    self.dependency = dependency
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
  }

  override func willResignActive() {
    super.willResignActive()
  }

  func didTapLoginButton(with user: User) {
    listener?.loginDidTapLoginButton(with: user)
  }
}
