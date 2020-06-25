// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repository",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "SwiftRepository", targets: ["Repository"])
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-cocoa.git", from: "5.1.0"),
        .package(url: "https://github.com/mxcl/PromiseKit.git", from: "6.13.2"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.2.1"),
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper.git", from: "4.2.0")
    ],
    targets: [
        .target(name: "Repository", dependencies: [], path: "Sources", exclude: ["Example", "Tests", "Package.relolved", "SwiftRepository.podspec"]),
        .testTarget(name: "RepositoryTests", dependencies: ["Repository"]),
    ],
    swiftLanguageVersions: [.v5]
)
