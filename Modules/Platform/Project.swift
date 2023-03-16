import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(
  name: "Platform",
  targetConfigurations: [
    TargetConfiguration(
      name: "APIService",
      productType: .framework,
      dependencies: [
        .project(target: "CoreLibraries", path: .relativeToRoot("Modules/CoreLibraries")),
      ]
    ),
    TargetConfiguration(
      name: "APIServiceImpl",
      targetTypes: [.unitTest],
      productType: .staticLibrary,
      dependencies: [
        .target(name: "APIService"),
      ]
    ),
    TargetConfiguration(
      name: "ImageLoader",
      targetTypes: [],
      productType: .framework
    ),
    TargetConfiguration(
      name: "ImageLoaderImpl",
      targetTypes: [.unitTest],
      productType: .staticLibrary,
      dependencies: [
        .target(name: "ImageLoader")
      ]
    ),
    TargetConfiguration(
      name: "Login",
      targetTypes: [],
      productType: .framework,
      dependencies: [
        .target(name: "PXUtilities"),
        .target(name: "SharedModels"),
      ]
    ),
    TargetConfiguration(
      name: "LoginImpl",
      targetTypes: [
        .unitTest,
        .preview,
      ],
      productType: .staticLibrary,
      dependencies: [
        .target(name: "Login"),
        .project(target: "PXDesignSystem", path: .relativeToRoot("Modules/PXDesignSystem")),
      ]
    ),
    TargetConfiguration(
      name: "PokemonRepository",
      targetTypes: [],
      productType: .framework,
      dependencies: [
        .target(name: "PXUtilities"),
        .target(name: "SharedModels"),
      ]
    ),
    TargetConfiguration(
      name: "PokemonRepositoryImpl",
      targetTypes: [.unitTest],
      productType: .staticLibrary,
      dependencies: [
        .target(name: "APIService"),
        .target(name: "PokemonRepository"),
      ]
    ),
    TargetConfiguration(
      name: "PXUtilities",
      targetTypes: [.unitTest],
      productType: .framework,
      dependencies: [
        .project(target: "CoreLibraries", path: .relativeToRoot("Modules/CoreLibraries")),
      ]
    ),
    TargetConfiguration(
      name: "RIBsTestSupport",
      targetTypes: [
        .unitTest,
      ],
      productType: .staticLibrary,
      dependencies: [
        .project(target: "CoreLibraries", path: .relativeToRoot("Modules/CoreLibraries")),
      ]
    ),
    TargetConfiguration(
      name: "RIBsUtil",
      targetTypes: [
        .unitTest,
      ],
      productType: .framework,
      dependencies: [
        .project(target: "CoreLibraries", path: .relativeToRoot("Modules/CoreLibraries")),
      ]
    ),
    TargetConfiguration(
      name: "SharedModels",
      targetTypes: [.unitTest],
      productType: .framework
    ),
  ],
  packages: [],
  additionalFiles: []
)
