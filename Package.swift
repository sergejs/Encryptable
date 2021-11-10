// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Encryptable",
    platforms: [
        .macOS(.v12),
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "Encryptable",
            targets: ["Encryptable"]),
    ],
    targets: [
        .target(
            name: "Encryptable",
            dependencies: []),
        .testTarget(
            name: "EncryptableTests",
            dependencies: ["Encryptable"]),
    ]
)
