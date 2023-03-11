import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .staticLibrary(
  name: "Discover",
  targetConfigurations: [
    TargetConfiguration(
      name: "DiscoverHome",
      targetTypes: [.unitTest, .preview],
      dependencies: []
    ),
  ],
  dependencies: [
    .project(target: "CoreLibraries", path: .relativeToRoot("Modules/CoreLibraries")),
    .project(target: "RIBsUtil", path: .relativeToRoot("Modules/Platform"))
  ],
  packages: [],
  additionalFiles: []
)
