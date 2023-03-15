//
//  TargetType.swift
//  ProjectDescriptionHelpers
//
//  Created by Geonhee on 2023/03/06.
//

import ProjectDescription

public enum TargetType {
  case unitTest
  case preview
}

public struct TargetConfiguration {
  public let name: String
  public let targetTypes: [TargetType]
  public let productType: Product
  public let dependencies: [TargetDependency]

  public init(
    name: String,
    targetTypes: [TargetType] = [],
    productType: Product,
    dependencies: [TargetDependency] = []
  ) {
    self.name = name
    self.targetTypes = targetTypes
    self.productType = productType
    self.dependencies = dependencies
  }
}
