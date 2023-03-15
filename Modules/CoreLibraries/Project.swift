import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(
  name: "CoreLibraries",
  targetConfigurations: [
    TargetConfiguration(
      name: "CoreLibraries",
      productType: .framework,
      dependencies: [
        .external(name: "RIBs"),
        .external(name: "RxCocoa"),
      ]
    ),
  ],
  packages: [],
  additionalFiles: []
)
