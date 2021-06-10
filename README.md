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
