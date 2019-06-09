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
            targets: ["WolfGeometry"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/WolfCore", .branch("Swift-5.1"))
//        .package(url: "https://github.com/wolfmcnally/WolfCore", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "WolfGeometry",
            dependencies: ["WolfCore"])
        ]
)
