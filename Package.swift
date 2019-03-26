// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "WolfGeometry",
    products: [
        .library(
            name: "WolfGeometry",
            targets: ["WolfGeometry"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/ExtensibleEnumeratedName", from: "2.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfNumerics", from: "4.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfStrings", from: "2.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfFoundation", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "WolfGeometry",
            dependencies: ["ExtensibleEnumeratedName", "WolfNumerics", "WolfStrings", "WolfFoundation"])
        ]
)
