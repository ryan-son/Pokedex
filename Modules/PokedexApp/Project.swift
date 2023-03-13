import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .app(
  name: "PokedexApp",
  dependencies: [
    .project(target: "APIServiceImpl", path: .relativeToRoot("Modules/Platform")),
    .project(target: "CatchHome", path: .relativeToRoot("Modules/Catch")),
    .project(target: "DiscoverHome", path: .relativeToRoot("Modules/Discover")),

  ],
  additionalFiles: [
    ".swiftlint.yml"
  ]
)
