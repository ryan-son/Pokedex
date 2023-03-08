import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .app(
  name: "PokedexApp",
  dependencies: [
    .project(target: "CX", path: .relativeToRoot("Modules/CX")),
    .project(target: "PXDesignSystem", path: .relativeToRoot("Modules/PXDesignSystem")),
  ],
  additionalFiles: [
    ".swiftlint.yml"
  ]
)
