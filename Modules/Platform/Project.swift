import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .framework(
  name: "Platform",
  targetConfigurations: [
    TargetConfiguration(name: "APIService"),
    TargetConfiguration(
      name: "APIServiceImpl",
      targetTypes: [.unitTest],
      dependencies: [
        .target(name: "APIService"),
      ]
    ),
    TargetConfiguration(
      name: "RIBsUtil",
      targetTypes: [.unitTest]
    ),
  ],
  dependencies: [
    .project(target: "CoreLibraries", path: .relativeToRoot("Modules/CoreLibraries"))
  ],
  packages: [],
  additionalFiles: []
)
