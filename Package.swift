// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repository",
    platforms: [.iOS(.v11)],
    products: [
             .library(
                 name: "SwiftRepository",
                 targets: ["Repository"])
         ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-cocoa.git", .upToNextMajor(from: "5.1.0")),
         .package(url: "https://github.com/mxcl/PromiseKit.git", .upToNextMajor(from: "6.13.2")),
         .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Repository",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "RepositoryTests",
            dependencies: ["Repository"]),
    ]
)
