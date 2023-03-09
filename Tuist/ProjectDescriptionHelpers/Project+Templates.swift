import ProjectDescription

// MARK: - Versions
public let appVersion: InfoPlist.Value = "0.1.0"
public let buildNumber: InfoPlist.Value = "1"
public let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "13.0", devices: .iphone)

// MARK: - Helpers
extension Project {

  static let bundleIdPrefix: String = "com.ryan-son"

  public static func app(
    name: String,
    dependencies: [TargetDependency],
    packages: [Package] = [],
    additionalFiles: [FileElement] = []
  ) -> Project {
    let mainTarget = Target(
      name: name,
      platform: .iOS,
      product: .app,
      bundleId: "\(bundleIdPrefix).\(name)",
      deploymentTarget: deploymentTarget,
      infoPlist: .app(version: appVersion, buildNumber: buildNumber),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      entitlements: nil,
      scripts: [.appSwiftLint],
      dependencies: dependencies,
      settings: nil,
      coreDataModels: [],
      launchArguments: [],
      additionalFiles: []
    )
    let unitTestTarget = Target(
      name: "\(name)Tests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "\(bundleIdPrefix).\(name)Tests",
      deploymentTarget: deploymentTarget,
      infoPlist: .default,
      sources: ["Tests/Sources/**", "Tests/Resources/**"],
      dependencies: [
        .target(name: name),
        .xctest
      ]
    )
    return Project(
      name: name,
      packages: packages,
      targets: [mainTarget, unitTestTarget],
      additionalFiles: additionalFiles
    )
  }

  public static func framework(
    name: String,
    targetConfiguration: [String: [DynamicFrameworkTargetType]],
    dependencies: [TargetDependency] = [],
    packages: [Package] = [],
    additionalFiles: [FileElement] = []
  ) -> Project {
    var projectTargets: [Target] = []

    targetConfiguration.forEach { (targetName, targetTypes) in
      let mainTarget = Target(
        name: targetName,
        platform: .iOS,
        product: .framework,
        bundleId: "\(bundleIdPrefix).\(targetName)",
        deploymentTarget: deploymentTarget,
        infoPlist: .default,
        sources: ["\(targetName)/Sources/**"],
        scripts: [.moduleSwiftLint],
        dependencies: dependencies,
        additionalFiles: additionalFiles
      )
      projectTargets.append(mainTarget)

      if targetTypes.contains(.unitTest) {
        let unitTestTarget = Target(
          name: "\(targetName)Tests",
          platform: .iOS,
          product: .unitTests,
          bundleId: "\(bundleIdPrefix).\(targetName)Tests",
          deploymentTarget: deploymentTarget,
          infoPlist: .default,
          sources: ["\(targetName)/Tests/Sources/**", "\(targetName)/Tests/Resources/**"],
          dependencies: [
            .target(name: targetName),
            .xctest
          ]
        )
        projectTargets.append(unitTestTarget)
      }

      if targetTypes.contains(.preview) {
        let previewAppTarget = Target(
          name: "\(targetName)PreviewApp",
          platform: .iOS,
          product: .app,
          bundleId: "\(bundleIdPrefix).\(targetName)PreviewApp",
          deploymentTarget: deploymentTarget,
          infoPlist: .app(version: appVersion, buildNumber: buildNumber),
          sources: ["\(targetName)/Preview/Sources/**"],
          resources: ["\(targetName)/Preview/Resources/**"],
          scripts: [.moduleSwiftLint],
          dependencies: [
            .target(name: targetName),
          ]
        )
        projectTargets.append(previewAppTarget)
      }
    }

    return Project(
      name: name,
      options: .options(disableSynthesizedResourceAccessors: true),
      packages: packages,
      targets: projectTargets
    )
  }

  public static func designSystemFramework(
    name: String,
    dependencies: [TargetDependency] = [],
    packages: [Package] = [],
    additionalFiles: [FileElement] = []
  ) -> Project {
    let mainTarget = Target(
      name: name,
      platform: .iOS,
      product: .framework,
      bundleId: "\(bundleIdPrefix).\(name)",
      deploymentTarget: deploymentTarget,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      scripts: [.moduleSwiftLint, .swiftGen],
      dependencies: dependencies,
      additionalFiles: additionalFiles + ["swiftgen.yml"]
    )
    return Project(
      name: name,
      options: .options(disableSynthesizedResourceAccessors: true),
      packages: packages,
      targets: [mainTarget]
    )
  }

  public static func staticLibrary(
    name: String,
    targetConfiguration: [String: [StaticLibraryTargetType]],
    dependencies: [TargetDependency] = [],
    packages: [Package] = [],
    additionalFiles: [FileElement]
  ) -> Project {
    var projectTargets: [Target] = []

    targetConfiguration.forEach { (targetName, targetTypes) in
      let mainTarget = Target(
        name: targetName,
        platform: .iOS,
        product: .staticLibrary,
        bundleId: "\(bundleIdPrefix).\(targetName)",
        deploymentTarget: deploymentTarget,
        infoPlist: .default,
        sources: ["\(targetName)/Sources/**"],
        scripts: [.moduleSwiftLint],
        dependencies: dependencies
      )
      projectTargets.append(mainTarget)

      if targetTypes.contains(.unitTest) {
        let testTarget = Target(
          name: "\(targetName)Tests",
          platform: .iOS,
          product: .unitTests,
          bundleId: "\(bundleIdPrefix).\(targetName)Tests",
          deploymentTarget: deploymentTarget,
          infoPlist: .default,
          sources: ["\(targetName)/Tests/Sources/**", "\(targetName)/Tests/Resources/**"],
          dependencies: [.target(name: targetName)]
        )
        projectTargets.append(testTarget)
      }

      if targetTypes.contains(.preview) {
        let previewAppTarget = Target(
          name: "\(targetName)PreviewApp",
          platform: .iOS,
          product: .app,
          bundleId: "\(bundleIdPrefix).\(targetName)PreviewApp",
          deploymentTarget: deploymentTarget,
          infoPlist: .app(version: appVersion, buildNumber: buildNumber),
          sources: ["\(targetName)/Preview/Sources/**"],
          resources: ["\(targetName)/Preview/Resources/**"],
          scripts: [.moduleSwiftLint],
          dependencies: [
            .target(name: targetName),
          ]
        )
        projectTargets.append(previewAppTarget)
      }
    }

    return Project(
      name: name,
      options: .options(disableSynthesizedResourceAccessors: true),
      packages: packages,
      targets: projectTargets,
      additionalFiles: additionalFiles
    )
  }
}

extension TargetScript {
  static let appSwiftLint: Self = .pre(script: Script.appSwiftLint, name: "SwiftLint")
  static let moduleSwiftLint: Self = .pre(script: Script.moduleSwiftLint, name: "SwiftLint")
  static let swiftGen: Self = .pre(script: Script.swiftGen, name: "SwiftGen")
}

extension InfoPlist {

  static func app(
    version: InfoPlist.Value,
    buildNumber: InfoPlist.Value
  ) -> Self {
    return .extendingDefault(
      with: [
        "CFBundleShortVersionString": version,
        "CFBundleVersion": buildNumber,
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen"
      ]
    )
  }
}

extension TargetScript.Script {

  static let appSwiftLint = """
  if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
  fi
  export PATH
  if which swiftlint >/dev/null; then
    swiftlint --fix && swiftlint
  else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
  fi
  """

  static let moduleSwiftLint = """
  if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
  fi
  export PATH
  if which swiftlint >/dev/null; then
    CONFIG_PATH="${SRCROOT}/../PokedexApp/.swiftlint.yml"
    swiftlint --fix --config "${CONFIG_PATH}" && swiftlint --config "${CONFIG_PATH}"
  else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
  fi
  """

  static let swiftGen = """
  if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
  fi
  export PATH
  if which swiftgen >/dev/null; then
    swiftgen
  else
    echo "warning: SwiftGen not installed, download it from https://github.com/SwiftGen/SwiftGen"
  fi
  """
}
