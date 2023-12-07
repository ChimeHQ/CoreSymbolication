<div align="center">

[![Platforms][platforms badge]][platforms]
[![Documentation][documentation badge]][documentation]
[![Discord][discord badge]][discord]

</div>

# CoreSymbolication
CoreSymbolication provides a very powerful system for looking up and extracting symbolic information from mach-o executables, dyld shared caches, and dSYMs.

There are two parts. The private C API itself is wrapped up in the `CoreSymbolication` target, and a Swift wrapper is provided with `SwiftCoreSymbolication`.

The private header is definitely not complete. But, if there's something you need/want, open up an issue and we can look into it together.

One quick note. I cannot figure out how to craft a modulemap that will allow SPM to handle linking. This means that you need to add some special linker flags to any executable target that uses this as a dependency.

```swift
linkerSettings: [
  .unsafeFlags([
  "-Xlinker", "-F",
  "-Xlinker", "/System/Library/PrivateFrameworks",
   "-Xlinker", "-framework",
   "-Xlinker", "CoreSymbolication",
]),
```

## Integration

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/ChimeHQ/CoreSymbolication")
],
targets: [
    .target(
        name: "UseCFunctionality",
        dependencies: ["CoreSymbolication"]
    ),
    .target(
        name: "UseSwiftWrapper",
        dependencies: [.product(name: "SwiftCoreSymbolication", package: "CoreSymbolication")]
    ),
]
```

## Contributing and Collaboration

I would love to hear from you! Issues or pull requests work great. A [Discord server][discord] is also available for live help, but I have a strong bias towards answering in the form of documenation.

I prefer collaboration, and would love to find ways to work together if you have a similar project.

I prefer indentation with tabs for improved accessibility. But, I'd rather you use the system you want and make a PR than hesitate because of whitespace.

By participating in this project you agree to abide by the [Contributor Code of Conduct](CODE_OF_CONDUCT.md).

[platforms]: https://swiftpackageindex.com/ChimeHQ/CoreSymbolication
[platforms badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FChimeHQ%2FCoreSymbolication%2Fbadge%3Ftype%3Dplatforms
[discord]: https://discord.gg/esFpX6sErJ
[discord badge]: https://img.shields.io/badge/Discord-purple?logo=Discord&label=Chat&color=%235A64EC
