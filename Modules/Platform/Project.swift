import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .framework(
  name: "Platform",
  targetConfiguration: [
    "RIBsUtil": [.unitTest]
  ],
  dependencies: [
    .project(target: "CoreLibraries", path: .relativeToRoot("Modules/CoreLibraries"))
  ],
  packages: [],
  additionalFiles: []
)
