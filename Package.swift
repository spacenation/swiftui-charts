// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Charts",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)
    ],
    products: [
        .library(name: "Charts", targets: ["Charts"])
    ],
    dependencies: [
        .package(name: "Shapes", url: "https://github.com/swift-extensions/swiftui-shapes.git", from: "0.1.0")
    ],
    targets: [
        .target(name: "Charts",dependencies: ["Shapes"]),
        .testTarget(name: "ChartsTests",dependencies: ["Charts"])
    ]
)
