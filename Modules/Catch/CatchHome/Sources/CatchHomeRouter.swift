//
//  CatchHomeRouter.swift
//  CatchHome
//
//  Created by Geonhee on 2023/03/13.
//

import RIBs

protocol CatchHomeInteractable: Interactable {
  var router: CatchHomeRouting? { get set }
  var listener: CatchHomeListener? { get set }
}

protocol CatchHomeViewControllable: ViewControllable {
}

final class CatchHomeRouter:
  ViewableRouter<CatchHomeInteractable, CatchHomeViewControllable>,
  CatchHomeRouting {

  override init(interactor: CatchHomeInteractable, viewController: CatchHomeViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  func routeToLogin() {

  }
}
