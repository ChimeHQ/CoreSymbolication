# CoreSymbolication

Headers and package for the CoreSymbolication private framework for macOS.

The header is definitely not complete. But, if there's something you need/want, open up an issue and we can look into it together.

One quick note. SPM seems to be unable to make use of a modulemap link directive. This means that you need to add some special linker flags to any executable target that uses this as a dependency.

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
]
```

## Suggestions or Feedback

We'd love to hear from you! Get in touch via [twitter](https://twitter.com/chimehq), an issue, or a pull request.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
