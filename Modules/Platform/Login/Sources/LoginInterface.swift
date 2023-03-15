//
//  LoginBuilder.swift
//  Login
//
//  Created by Geonhee on 2023/03/13.
//

import PXUtilities
import RIBs
import SharedModels

public protocol LoginDependency: Dependency {
  var user: ReadOnlyBehaviorSubject<User?> { get }
}

public protocol LoginBuildable: Buildable {
  func build(withListener listener: LoginListener) -> ViewableRouting
}

public protocol LoginListener: AnyObject {
  func loginDidTapLoginButton(with user: User)
}
