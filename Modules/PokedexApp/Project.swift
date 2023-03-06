import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .app(
  name: "PokedexApp",
  dependencies: [
    .project(target: "PokedexKit", path: .relativeToRoot("Modules/PokedexKit")),
    .project(target: "PokedexUI", path: .relativeToRoot("Modules/PokedexUI"))
  ],
  additionalFiles: [
    ".swiftlint.yml"
  ]
)
