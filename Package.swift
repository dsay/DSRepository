// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repository",
    platforms: [.macOS(.v10_12),
                .iOS(.v11),
                .tvOS(.v10),
                .watchOS(.v3)],
    products: [
        .library(name: "Repository", targets: ["Repository"])
    ],
    dependencies: [
        .package(name: "PromiseKit", url: "https://github.com/mxcl/PromiseKit.git", from: "6.13.2"),
        .package(name: "Alamofire", url: "https://github.com/Alamofire/Alamofire.git", from: "5.2.1"),
        .package(name: "ObjectMapper", url: "https://github.com/tristanhimmelman/ObjectMapper.git", from: "4.2.0")
    ],
    targets: [
        .target(name: "Repository",
                dependencies: ["Alamofire", "ObjectMapper", "PromiseKit"],
                path: "Sources/Repositroy"),
        .testTarget(name: "RepositoryTests", dependencies: ["Repository"]),
    ],
    swiftLanguageVersions: [.v5]
)
