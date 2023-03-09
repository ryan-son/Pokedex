import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .staticLibrary(
  name: "Discover",
  targetConfiguration: [
    "DiscoverHome": [.unitTest, .preview]
  ],
  dependencies: [
    .project(target: "CoreLibraries", path: .relativeToRoot("Modules/CoreLibraries"))
  ],
  packages: [],
  additionalFiles: []
)
