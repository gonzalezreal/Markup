// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Markup",
    platforms: [
        .iOS(.v8),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(name: "Markup", targets: ["Markup"]),
    ],
    targets: [
        .target(name: "Markup", dependencies: []),
        .testTarget(name: "MarkupTests", dependencies: ["Markup"]),
    ]
)
