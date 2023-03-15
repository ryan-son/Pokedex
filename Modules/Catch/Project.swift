import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .feature(
  name: "Catch",
  targetConfigurations: [
    TargetConfiguration(
      name: "CatchHome",
      targetTypes: [.unitTest, .preview],
      productType: .staticLibrary,
      dependencies: [
        .project(target: "ImageLoader", path: .relativeToRoot("Modules/Platform")),
        .project(target: "Login", path: .relativeToRoot("Modules/Platform")),
        .project(target: "PokemonRepository", path: .relativeToRoot("Modules/Platform")),
        .project(target: "PXDesignSystem", path: .relativeToRoot("Modules/PXDesignSystem")),
      ]
    ),
  ],
  packages: [],
  additionalFiles: []
)
