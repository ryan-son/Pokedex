//
//  LoginRouter.swift
//  Login
//
//  Created by Geonhee on 2023/03/13.
//

import Login
import RIBs

protocol LoginInteractable: Interactable {
  var router: LoginRouting? { get set }
  var listener: LoginListener? { get set }
}

protocol LoginViewControllable: ViewControllable {
}

final class LoginRouter: ViewableRouter<LoginInteractable, LoginViewControllable>, LoginRouting {

  override init(interactor: LoginInteractable, viewController: LoginViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}
