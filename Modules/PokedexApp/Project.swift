import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .app(
  name: "PokedexApp",
  dependencies: [
    .project(target: "PokedexKit", path: .relativeToRoot("Modules/PokedexKit")),
    .project(target: "PXDesignSystem", path: .relativeToRoot("Modules/PXDesignSystem"))
  ],
  additionalFiles: [
    ".swiftlint.yml"
  ]
)
