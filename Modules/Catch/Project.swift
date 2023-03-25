import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(
  name: "Catch",
  targetConfigurations: [
    TargetConfiguration(
      name: "CatchHome",
      targetTypes: [],
      productType: .framework,
      dependencies: [
        .project(target: "ImageLoader", path: .relativeToRoot("Modules/Platform")),
        .project(target: "Login", path: .relativeToRoot("Modules/Platform")),
        .project(target: "PokemonRepository", path: .relativeToRoot("Modules/Platform")),
      ]
    ),
    TargetConfiguration(
      name: "CatchHomeImpl",
      targetTypes: [.unitTest, .preview],
      productType: .staticLibrary,
      dependencies: [
        .target(name: "CatchHome"),
        .project(target: "RIBsUtil", path: .relativeToRoot("Modules/Platform")),
        .project(target: "PXDesignSystem", path: .relativeToRoot("Modules/PXDesignSystem")),
      ],
      unitTestDependencies: [
        .project(target: "PokemonRepositoryTestSupport", path: .relativeToRoot("Modules/Platform")),
        .project(target: "RIBsTestSupport", path: .relativeToRoot("Modules/Platform")),
      ]
    ),
  ],
  packages: [],
  additionalFiles: []
)
