//
//  LoginInteractor.swift
//  Login
//
//  Created by Geonhee on 2023/03/13.
//

import RIBs
import RxSwift

protocol LoginRouting: ViewableRouting {
}

protocol LoginPresentable: Presentable {
  var listener: LoginPresentableListener? { get set }
}

protocol LoginListener: AnyObject {
}

final class LoginInteractor: PresentableInteractor<LoginPresentable>, LoginInteractable, LoginPresentableListener {

  weak var router: LoginRouting?
  weak var listener: LoginListener?

  override init(presenter: LoginPresentable) {
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
