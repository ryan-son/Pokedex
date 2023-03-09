import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .framework(
  name: "CoreLibraries",
  targetConfiguration: [
    "CoreLibraries": []
  ],
  dependencies: [
    .external(name: "RIBs")
  ],
  packages: [],
  additionalFiles: []
)
