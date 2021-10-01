// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "Charts",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(name: "Charts", targets: ["Charts"])
    ],
    dependencies: [
        .package(name: "Shapes", url: "https://github.com/spacenation/swiftui-shapes.git", .upToNextMajor(from: "1.1.0"))
    ],
    targets: [
        .target(name: "Charts",dependencies: ["Shapes"])
    ]
)
