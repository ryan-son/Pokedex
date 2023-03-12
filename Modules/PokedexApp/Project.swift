import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .app(
  name: "PokedexApp",
  dependencies: [
    .project(target: "APIServiceImpl", path: .relativeToRoot("Modules/Platform")),
    .project(target: "DiscoverHome", path: .relativeToRoot("Modules/Discover"))
  ],
  additionalFiles: [
    ".swiftlint.yml"
  ]
)
