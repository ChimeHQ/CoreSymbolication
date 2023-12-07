import Foundation
import CoreSymbolication

public class SymbolOwner {
    private let ownerRef: CSSymbolOwnerRef

    init(internalOwner: CSSymbolOwnerRef) {
        self.ownerRef = CSRetain(internalOwner)
    }

    deinit {
        CSRelease(ownerRef)
    }

   public var uuid: UUID? {
       guard let uuidBytes = CSSymbolOwnerGetCFUUIDBytes(self.ownerRef) else {
           return nil
       }

       guard let cfUUID = CFUUIDCreateFromUUIDBytes(kCFAllocatorDefault, uuidBytes.pointee) else {
           return nil
       }

       let stringRep = CFUUIDCreateString(kCFAllocatorDefault, cfUUID) as String

       return UUID(uuidString: stringRep)
   }

    public var architecture: Architecture {
        let arch = CSSymbolOwnerGetArchitecture(self.ownerRef)

        return Architecture(arch: arch)
    }

   public var baseAddress: UInt64 {
       return UInt64(CSSymbolOwnerGetBaseAddress(self.ownerRef))
   }

   public var path: String {
       return String(cString: CSSymbolOwnerGetPath(self.ownerRef))
   }

   public var url: URL {
       return URL(fileURLWithPath: path)
   }

    public func enumerateSymbols(_ block: (Symbol) -> Void) {
        withoutActuallyEscaping(block) { (block) in
            CSSymbolOwnerForeachSymbol(ownerRef) { (symbolRef) in
                let symbol = Symbol(symbolRef: symbolRef)

                block(symbol)
            }
        }
    }
}

