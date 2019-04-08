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
        .package(url: "https://github.com/wolfmcnally/WolfCore", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "WolfGeometry",
            dependencies: ["WolfCore"])
        ]
)
