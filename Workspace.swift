
import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Workspace
// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

let workspace = Workspace(
  name: "Pokedex",
  projects: [
    "Modules/PokedexApp",
    "Modules/PokedexKit",
    "Modules/PokedexUI",
  ],
  additionalFiles: []
)
