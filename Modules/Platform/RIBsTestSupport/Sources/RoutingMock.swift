//
//  RoutingMock.swift
//  RoutingMock
//
//  Created by Geonhee on 2023/03/15.
//

import RxSwift
import RIBs

public final class RoutingMock: Routing {

  public var loadHandler: (() -> Void)?
  public var loadCallCount: Int = 0
  public var attachChildHandler: ((_ child: Routing) -> Void)?
  public var attachChildCallCount: Int = 0
  public var detachChildHandler: ((_ child: Routing) -> Void)?
  public var detachChildCallCount: Int = 0

  public var interactable: Interactable

  public var children: [Routing] = [Routing]() { didSet { childrenSetCallCount += 1 } }
  public var childrenSetCallCount = 0

  public init(
    interactable: Interactable
  ) {
    self.interactable = interactable
  }

  public func load() {
    loadCallCount += 1
    if let loadHandler = loadHandler {
      return loadHandler()
    }
  }

  public func attachChild(_ child: Routing) {
    attachChildCallCount += 1
    if let attachChildHandler = attachChildHandler {
      return attachChildHandler(child)
    }
  }

  public func detachChild(_ child: Routing) {
    detachChildCallCount += 1
    if let detachChildHandler = detachChildHandler {
      return detachChildHandler(child)
    }
  }

  public var lifecycleSubject = PublishSubject<RouterLifecycle>() {
    didSet {
      lifecycleSubjectSetCallCount += 1
    }
  }
  public var lifecycleSubjectSetCallCount = 0
  public var lifecycle: Observable<RouterLifecycle> { return lifecycleSubject.asObservable() }
}
