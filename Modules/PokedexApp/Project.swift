import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .app(
  name: "PokedexApp",
  dependencies: [
    .project(target: "DiscoverHome", path: .relativeToRoot("Modules/Discover")),
    .project(target: "PXDesignSystem", path: .relativeToRoot("Modules/PXDesignSystem")),
  ],
  additionalFiles: [
    ".swiftlint.yml"
  ]
)
