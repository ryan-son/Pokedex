//
//  AppRootRouter.swift
//  PokedexApp
//
//  Created by Geonhee on 2023/03/09.
//

import DiscoverHome
import RIBs

protocol AppRootInteractable: Interactable, DiscoverHomeListener {
  var router: AppRootRouting? { get set }
  var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
  func setViewControllers(_ viewControllers: [ViewControllable])
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {

  private let discoverHomeBuilder: DiscoverHomeBuildable
  private var discoverHomeRouting: ViewableRouting?

  init(
    interactor: AppRootInteractable,
    viewController: AppRootViewControllable,
    discoverHomeBuilder: DiscoverHomeBuilder
  ) {
    self.discoverHomeBuilder = discoverHomeBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  func attachTaps() {
    let discoverHomeRouting = discoverHomeBuilder.build(withListener: interactor)

    attachChild(discoverHomeRouting)

    let viewControllers = [
      discoverHomeRouting.viewControllable
    ]

    viewController.setViewControllers(viewControllers)
  }
}
