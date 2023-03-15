//
//  CatchHomeRouter.swift
//  CatchHome
//
//  Created by Geonhee on 2023/03/13.
//

import CatchHome
import Login
import RIBs
import RIBsUtil

protocol CatchHomeInteractable: Interactable, LoginListener {
  var router: CatchHomeRouting? { get set }
  var listener: CatchHomeListener? { get set }
}

protocol CatchHomeViewControllable: ViewControllable {
}

final class CatchHomeRouter:
  ViewableRouter<CatchHomeInteractable, CatchHomeViewControllable>,
  CatchHomeRouting {

  private let loginBuilder: LoginBuildable
  private var loginRouter: ViewableRouting?

  init(
    interactor: CatchHomeInteractable,
    viewController: CatchHomeViewControllable,
    loginBuilder: LoginBuildable
  ) {
    self.loginBuilder = loginBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  func routeToLogin() {
    guard loginRouter == nil else { return }

    let router = loginBuilder.build(withListener: interactor)
    viewController.present(router.viewControllable, animated: true, completion: nil)
    loginRouter = router
    attachChild(router)
  }

  func detachLogin() {
    guard let router = loginRouter else { return }

    router.viewControllable.dismiss(completion: nil)
    loginRouter = nil
    detachChild(router)
  }
}
