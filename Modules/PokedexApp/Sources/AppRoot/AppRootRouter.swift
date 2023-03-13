//
//  AppRootRouter.swift
//  PokedexApp
//
//  Created by Geonhee on 2023/03/09.
//

import CatchHome
import DiscoverHome
import ImageLoader
import RIBs
import RIBsUtil

protocol AppRootInteractable:
  Interactable,
  DiscoverHomeListener,
  CatchHomeListener {
  var router: AppRootRouting? { get set }
  var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
  func setViewControllers(_ viewControllers: [ViewControllable])
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {

  private let discoverHomeBuilder: DiscoverHomeBuildable
  private var discoverHomeRouting: ViewableRouting?

  private let catchHomeBuilder: CatchHomeBuildable
  private var catchHomeRouting: ViewableRouting?

  private let imageLoader: ImageLoader

  init(
    interactor: AppRootInteractable,
    viewController: AppRootViewControllable,
    imageLoader: ImageLoader,
    discoverHomeBuilder: DiscoverHomeBuildable,
    catchHomeBuilder: CatchHomeBuildable
  ) {
    self.imageLoader = imageLoader
    self.discoverHomeBuilder = discoverHomeBuilder
    self.catchHomeBuilder = catchHomeBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  func attachTaps() {
    let discoverHomeRouting = discoverHomeBuilder.build(withListener: interactor)
    let catchHomeRouting = catchHomeBuilder.build(withListener: interactor)

    attachChild(discoverHomeRouting)
    attachChild(catchHomeRouting)

    let viewControllers = [
      NavigationControllerable(root: discoverHomeRouting.viewControllable),
      NavigationControllerable(root: catchHomeRouting.viewControllable),
    ]

    viewController.setViewControllers(viewControllers)
  }
}
