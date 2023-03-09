
import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Workspace
// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

let workspace = Workspace(
  name: "Pokedex",
  projects: [
    "Modules/CoreLibraries",
    "Modules/Discover",
    "Modules/Platform",
    "Modules/PokedexApp",
    "Modules/PXDesignSystem",
  ],
  additionalFiles: []
)
