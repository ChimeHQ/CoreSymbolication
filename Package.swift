// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreSymbolication",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(name: "CoreSymbolication", targets: ["CoreSymbolication"])
    ],
    dependencies: [
    ],
    targets: [
        .systemLibrary(name: "CoreSymbolication"),
        .testTarget(name: "CoreSymbolicationTests",
                    dependencies: ["CoreSymbolication"],
                    linkerSettings: [
                      .unsafeFlags([
                        "-Xlinker", "-F",
                        "-Xlinker", "/System/Library/PrivateFrameworks",
                        "-Xlinker", "-framework",
                        "-Xlinker", "CoreSymbolication",
                      ]),
                    ]),
    ],
    swiftLanguageVersions: [.v5]
)
