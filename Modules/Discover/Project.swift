import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(
  name: "Discover",
  targetConfigurations: [
    TargetConfiguration(
      name: "DiscoverHome",
      targetTypes: [.unitTest, .preview],
      productType: .staticLibrary,
      dependencies: [
        .target(name: "DiscoverDetail"),
        .project(target: "PokemonRepository", path: .relativeToRoot("Modules/Platform")),
        .project(target: "PXDesignSystem", path: .relativeToRoot("Modules/PXDesignSystem")),
      ]
    ),
    TargetConfiguration(
      name: "DiscoverDetail",
      targetTypes: [.unitTest, .preview],
      productType: .staticLibrary,
      dependencies: [
        .project(target: "ImageLoader", path: .relativeToRoot("Modules/Platform")),
        .project(target: "RIBsUtil", path: .relativeToRoot("Modules/Platform")),
        .project(target: "SharedModels", path: .relativeToRoot("Modules/Platform")),
      ]
    ),
  ],
  packages: [],
  additionalFiles: []
)
