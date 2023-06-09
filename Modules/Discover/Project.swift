import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(
  name: "Discover",
  targetConfigurations: [
    TargetConfiguration(
      name: "DiscoverHome",
      targetTypes: [],
      productType: .framework,
      dependencies: [
        .target(name: "DiscoverDetail"),
        .project(target: "PokemonRepository", path: .relativeToRoot("Modules/Platform")),
      ]
    ),
    TargetConfiguration(
      name: "DiscoverHomeImpl",
      targetTypes: [.unitTest, .preview],
      productType: .staticLibrary,
      dependencies: [
        .target(name: "DiscoverHome"),
        .project(target: "RIBsUtil", path: .relativeToRoot("Modules/Platform")),
        .project(target: "PXDesignSystem", path: .relativeToRoot("Modules/PXDesignSystem")),
      ],
      unitTestDependencies: [
        .project(target: "PokemonRepositoryTestSupport", path: .relativeToRoot("Modules/Platform")),
        .project(target: "RIBsTestSupport", path: .relativeToRoot("Modules/Platform")),
      ]
    ),
    TargetConfiguration(
      name: "DiscoverDetail",
      targetTypes: [],
      productType: .framework,
      dependencies: [
        .project(target: "CoreLibraries", path: .relativeToRoot("Modules/CoreLibraries")),
        .project(target: "ImageLoader", path: .relativeToRoot("Modules/Platform")),
        .project(target: "SharedModels", path: .relativeToRoot("Modules/Platform")),
      ]
    ),
    TargetConfiguration(
      name: "DiscoverDetailImpl",
      targetTypes: [.unitTest, .preview],
      productType: .staticLibrary,
      dependencies: [
        .target(name: "DiscoverDetail"),
      ],
      unitTestDependencies: [
        .project(target: "RIBsTestSupport", path: .relativeToRoot("Modules/Platform")),
      ]
    ),
  ],
  packages: [],
  additionalFiles: []
)
