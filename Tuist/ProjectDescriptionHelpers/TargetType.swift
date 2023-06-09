//
//  TargetType.swift
//  ProjectDescriptionHelpers
//
//  Created by Geonhee on 2023/03/06.
//

import ProjectDescription

public struct TargetConfiguration {

  public enum TargetType {
    case unitTest
    case preview
  }

  public let name: String
  public let targetTypes: [TargetType]
  public let productType: Product
  public let dependencies: [TargetDependency]
  public let unitTestDependencies: [TargetDependency]
  public let uiTestTestDependencies: [TargetDependency]

  public init(
    name: String,
    targetTypes: [TargetType] = [],
    productType: Product,
    dependencies: [TargetDependency] = [],
    unitTestDependencies: [TargetDependency] = [],
    uiTestTestDependencies: [TargetDependency] = []
  ) {
    self.name = name
    self.targetTypes = targetTypes
    self.productType = productType
    self.dependencies = dependencies
    self.unitTestDependencies = unitTestDependencies
    self.uiTestTestDependencies = uiTestTestDependencies
  }
}

