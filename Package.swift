// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Encryptable",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "Encryptable",
            type: .dynamic,
            targets: ["Encryptable"]
        ),
    ],
    targets: [
        .target(
            name: "Encryptable",
            dependencies: []
        ),
        .testTarget(
            name: "EncryptableTests",
            dependencies: ["Encryptable"]
        ),
    ]
)
