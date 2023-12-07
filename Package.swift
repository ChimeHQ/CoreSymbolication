// swift-tools-version:5.3

import PackageDescription

let package = Package(
	name: "CoreSymbolication",
	platforms: [.macOS(.v10_15)],
	products: [
		.library(name: "CoreSymbolication", targets: ["CoreSymbolication"]),
		.library(name: "SwiftCoreSymbolication", targets: ["SwiftCoreSymbolication"]),
	],
	targets: [
		.systemLibrary(name: "CoreSymbolication"),
		.target(
			name: "LinkedTarget",
			dependencies: ["CoreSymbolication"],
			linkerSettings: [
				.unsafeFlags([
					"-Xlinker", "-F",
					"-Xlinker", "/System/Library/PrivateFrameworks",
					"-Xlinker", "-framework",
					"-Xlinker", "CoreSymbolication",
				]),
			]
		),
		.testTarget(
			name: "CoreSymbolicationTests",
			dependencies: ["CoreSymbolication", "LinkedTarget"],
			linkerSettings: [
//				.unsafeFlags([
//					"-Xlinker", "-F",
//					"-Xlinker", "/System/Library/PrivateFrameworks",
//					"-Xlinker", "-framework",
//					"-Xlinker", "CoreSymbolication",
//				]),
			]
		),
		.target(
			name: "SwiftCoreSymbolication",
			dependencies: ["CoreSymbolication", "LinkedTarget"]
		),
		.testTarget(
			name: "SwiftCoreSymbolicationTests",
			dependencies: ["SwiftCoreSymbolication"],
			resources: [
				.copy("TestData"),
			]
		)
	]
)
