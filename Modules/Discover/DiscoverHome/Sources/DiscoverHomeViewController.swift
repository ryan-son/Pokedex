//
//  DiscoverHomeViewController.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import RIBs
import RxSwift
import UIKit

protocol DiscoverHomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class DiscoverHomeViewController: UIViewController, DiscoverHomePresentable, DiscoverHomeViewControllable {

    weak var listener: DiscoverHomePresentableListener?
}
