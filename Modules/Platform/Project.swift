import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .framework(
  name: "Platform",
  targetConfigurations: [
    TargetConfiguration(name: "APIService"),
    TargetConfiguration(
      name: "APIServiceImpl",
      targetTypes: [.unitTest],
      dependencies: [
        .target(name: "APIService"),
      ]
    ),
    TargetConfiguration(
      name: "ImageLoader",
      targetTypes: [.unitTest]
    ),
    TargetConfiguration(
      name: "Login",
      targetTypes: [
        .unitTest,
        .preview,
      ],
      dependencies: [
        .target(name: "PXUtilities"),
        .target(name: "RIBsUtil"),
        .target(name: "SharedModels"),
        .project(target: "PXDesignSystem", path: .relativeToRoot("Modules/PXDesignSystem")),
      ]
    ),
    TargetConfiguration(
      name: "PokemonRepository",
      targetTypes: [.unitTest],
      dependencies: [
        .target(name: "APIService"),
        .target(name: "PXUtilities"),
        .target(name: "SharedModels"),
      ]
    ),
    TargetConfiguration(
      name: "PXUtilities",
      targetTypes: [.unitTest],
      dependencies: [
        .project(target: "CoreLibraries", path: .relativeToRoot("Modules/CoreLibraries")),
      ]
    ),
    TargetConfiguration(
      name: "RIBsUtil",
      targetTypes: [
        .unitTest,
      ],
      dependencies: [
        .project(target: "CoreLibraries", path: .relativeToRoot("Modules/CoreLibraries")),
      ]
    ),
    TargetConfiguration(
      name: "SharedModels",
      targetTypes: [.unitTest]
    ),
  ],
  dependencies: [],
  packages: [],
  additionalFiles: []
)
