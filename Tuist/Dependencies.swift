//
//  Dependencies.swift
//  Config
//
//  Created by Geonhee on 2023/03/08.
//

import ProjectDescription

let dependencies = Dependencies(
  carthage: nil,
  swiftPackageManager: SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/uber/RIBs", requirement: .upToNextMajor(from: "0.13.2")),
  ]),
  platforms: [.iOS]
)
