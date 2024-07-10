// swift-tools-version: 5.9
//
//  Package.swift
//  TermKitBackend
//
//  Created by david-swift on 01.07.2024.
//

import PackageDescription

/// The TermKitBackend package.
let package = Package(
    name: "TermKitBackend",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "TermKitBackend",
            targets: ["TermKitBackend"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/AparokshaUI/Meta", branch: "main"),
        .package(url: "https://github.com/david-swift/TermKit", branch: "main")
    ],
    targets: [
        .target(
            name: "TermKitBackend",
            dependencies: ["TermKit", "Meta"]
        ),
        .executableTarget(
            name: "TestApp",
            dependencies: ["TermKitBackend"]
        )
    ]
)
