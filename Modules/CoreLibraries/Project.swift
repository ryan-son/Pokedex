import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .framework(
  name: "CoreLibraries",
  targetTypes: [],
  dependencies: [
    .external(name: "RIBs")
  ],
  packages: [],
  additionalFiles: []
)
