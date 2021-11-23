// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RapidSwift",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "RapidSwift",
            targets: ["RapidSwift"]),
    ],
    dependencies: [ ],
    targets: [
        .target(
            name: "RapidSwift",
            path: "Sources"
        ),
        .testTarget(
            name: "RapidSwiftTests",
            dependencies: ["RapidSwift"]),
    ]
)
