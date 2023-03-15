import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .app(
  name: "PokedexApp",
  dependencies: [
    .project(target: "CatchHomeImpl", path: .relativeToRoot("Modules/Catch")),
    .project(target: "DiscoverHomeImpl", path: .relativeToRoot("Modules/Discover")),
    .project(target: "DiscoverDetailImpl", path: .relativeToRoot("Modules/Discover")),
    .project(target: "APIServiceImpl", path: .relativeToRoot("Modules/Platform")),
    .project(target: "ImageLoaderImpl", path: .relativeToRoot("Modules/Platform")),
    .project(target: "LoginImpl", path: .relativeToRoot("Modules/Platform")),
    .project(target: "PokemonRepositoryImpl", path: .relativeToRoot("Modules/Platform")),
  ],
  additionalFiles: [
    ".swiftlint.yml"
  ]
)
