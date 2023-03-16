//
//  InteractableMock.swift
//  RIBsTestSupport
//
//  Created by Geonhee on 2023/03/16.
//

import RxSwift
import RIBs

open class InteractableMock: Interactable {
  public func activate() {}

  public func deactivate() {}

  public var isActive: Bool { (try? isActiveSubject.value()) ?? false }
  public var isActiveStream: Observable<Bool> { isActiveSubject.asObservable() }
  private let isActiveSubject = BehaviorSubject(value: false)

  public init() {}
}
