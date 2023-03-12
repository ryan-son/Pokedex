//
//  ReadOnlyBehaviorSubject.swift
//  RIBsUtil
//
//  Created by Geonhee on 2023/03/13.
//

import RxSwift

public final class ReadOnlyBehaviorSubject<Element>: ObservableType {

  typealias E = Element

  private let subject: BehaviorSubject<Element>

  public init(for subject: BehaviorSubject<Element>) {
    self.subject = subject
  }

  public func subscribe<Observer>(
    _ observer: Observer
  ) -> Disposable where Observer: ObserverType, Element == Observer.Element {
    return subject.asObservable().subscribe(observer)
  }

  public func asObservable() -> Observable<Element> {
    return subject.asObservable()
  }

  public var value: Element? {
    return (try? subject.value())
  }
}
