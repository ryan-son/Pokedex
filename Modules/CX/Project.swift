import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .staticLibrary(
  name: "CX",
  targetTypes: [
    .unitTest
  ],
  dependencies: [
    .project(target: "CoreLibraries", path: .relativeToRoot("Modules/CoreLibraries"))
  ],
  packages: [],
  additionalFiles: []
)
