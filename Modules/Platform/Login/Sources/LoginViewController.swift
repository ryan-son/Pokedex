//
//  LoginViewController.swift
//  Login
//
//  Created by Geonhee on 2023/03/13.
//

import RIBs
import RxSwift
import UIKit

protocol LoginPresentableListener: AnyObject {
}

final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable {

  weak var listener: LoginPresentableListener?
}
