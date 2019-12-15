// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "WolfGeometry",
    platforms: [
        .iOS(.v9), .macOS(.v10_13), .tvOS(.v11)
    ],
    products: [
        .library(
            name: "WolfGeometry",
            type: .dynamic,
            targets: ["WolfGeometry"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/WolfCore", from: "5.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfNumerics", from: "4.0.0"),
        .package(url: "https://github.com/wolfmcnally/ExtensibleEnumeratedName", from: "2.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfStrings", from: "2.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfFoundation", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "WolfGeometry",
            dependencies: [
                "WolfCore",
                "WolfNumerics",
                "ExtensibleEnumeratedName",
                "WolfStrings",
                "WolfFoundation"
        ])
        ]
)
