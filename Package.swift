// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Encryptable",
    platforms: [
        .iOS(.v15),
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
