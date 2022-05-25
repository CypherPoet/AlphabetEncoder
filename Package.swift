// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlphabetEncoder",
    defaultLocalization: "en",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "AlphabetEncoder",
            targets: [
                "AlphabetEncoder",
            ]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(
            url: "https://github.com/apple/swift-docc-plugin",
            from: "1.0.0"
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "AlphabetEncoder",
            dependencies: [
            ],
            path: "Sources/AlphabetEncoder/",
            exclude: [
                "Resources/README.txt",
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "AlphabetEncoderTests",
            dependencies: [
                "AlphabetEncoder",
            ],
            path: "Tests/AlphabetEncoder/",
            exclude: [
                "Resources/README.txt",
                "Toolbox/README.txt",
            ],
            resources: [
                .process("Resources"),
            ]
        ),
    ]
)
