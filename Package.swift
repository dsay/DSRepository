// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repository",
    platforms: [.macOS(.v12),
                .iOS(.v13),
                .tvOS(.v9),
                .watchOS(.v2)],
    products: [
        .library(name: "Repository", targets: ["Repository"])
    ],
    dependencies: [
        .package(name: "PromiseKit", url: "https://github.com/mxcl/PromiseKit.git", from: "6.13.2"),
        .package(name: "Alamofire", url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.1"),
        .package(name: "ObjectMapper", url: "https://github.com/tristanhimmelman/ObjectMapper.git", from: "4.4.3")
    ],
    targets: [
        .target(name: "Repository",
                dependencies: ["Alamofire", "ObjectMapper", "PromiseKit"],
                path: "Sources"),
        .testTarget(name: "RepositoryTests", dependencies: ["Repository"]),
    ],
    swiftLanguageVersions: [.v5]
)
