//
//  DiscoverDetailViewController.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

import RIBs
import RxSwift
import UIKit

protocol DiscoverDetailPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
}

final class DiscoverDetailViewController: UIViewController, DiscoverDetailPresentable, DiscoverDetailViewControllable {
  
  weak var listener: DiscoverDetailPresentableListener?
}
