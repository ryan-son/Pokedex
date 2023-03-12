import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .staticLibrary(
  name: "Discover",
  targetConfigurations: [
    TargetConfiguration(
      name: "DiscoverHome",
      targetTypes: [.unitTest, .preview],
      dependencies: []
    ),
  ],
  dependencies: [
    .project(target: "CoreLibraries", path: .relativeToRoot("Modules/CoreLibraries")),
    .project(target: "ImageLoader", path: .relativeToRoot("Modules/Platform")),
    .project(target: "PokemonRepository", path: .relativeToRoot("Modules/Platform")),
    .project(target: "PXDesignSystem", path: .relativeToRoot("Modules/PXDesignSystem")),
    .project(target: "RIBsUtil", path: .relativeToRoot("Modules/Platform"))
  ],
  packages: [],
  additionalFiles: []
)
