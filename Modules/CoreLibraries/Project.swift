import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .framework(
  name: "CoreLibraries",
  targetConfigurations: [
    TargetConfiguration(name: "CoreLibraries"),
  ],
  dependencies: [
    .external(name: "RIBs"),
    .external(name: "RxCocoa"),
    .external(name: "RxSwift"),
  ],
  packages: [],
  additionalFiles: []
)
