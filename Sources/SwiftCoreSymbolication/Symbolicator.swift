import Foundation
import CoreSymbolication

public class Symbolicator {
    private let internalSymbolicator: CSSymbolicatorRef

    init(symbolicatorRef: CSSymbolicatorRef) {
        self.internalSymbolicator = CSRetain(symbolicatorRef)
    }

    deinit {
        CSRelease(self.internalSymbolicator)
    }

    public var symbolOwners: [SymbolOwner] {
        var owners = [SymbolOwner]()

        CSSymbolicatorForeachSymbolOwnerAtTime(self.internalSymbolicator, UInt64(kCSNow)) { (ownerRef) in
            let owner = SymbolOwner(internalOwner: ownerRef)

            owners.append(owner)
        }

        return owners
    }

    public var architecture: Architecture {
        let arch = CSSymbolicatorGetArchitecture(self.internalSymbolicator)

        return Architecture(arch: arch)
    }
}

extension Symbolicator {
    public static func symbolicators(at url: URL) -> [Symbolicator] {
        var values: [Symbolicator] = []

        CSSymbolicatorForeachSymbolicatorWithURL(url as CFURL) { (symbolicatorRef) in
            let symbolicator = Symbolicator(symbolicatorRef: symbolicatorRef)

            values.append(symbolicator)
        }

        return values
    }

    public static func sharedCacheSymbolicators() -> [Symbolicator] {
        var values: [Symbolicator] = []

        CSSymbolicatorForeachSharedCache { (symbolicatorRef) in
            let symbolicator = Symbolicator(symbolicatorRef: symbolicatorRef)

            values.append(symbolicator)
        }

        return values
    }
}

