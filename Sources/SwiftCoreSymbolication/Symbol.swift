import Foundation
import CoreSymbolication

public class Symbol {
    private let symbolRef: CSSymbolRef

    init(symbolRef: CSSymbolRef) {
        self.symbolRef = CSRetain(symbolRef)
    }

    deinit {
        CSRelease(self.symbolRef)
    }

    public var isFunction: Bool {
        return CSSymbolIsFunction(symbolRef)
    }

//    public var hasInlinedSourceInfo: Bool {
//        return CSSymbolHasInlinedSourceInfo(symbolRef)
//    }
//
//    public func enumerateInlineRanges(_ block: (CSRange) -> Void) {
//        CSSymbolForeachInlineRange(symbolRef, block)
//    }
//
//    public func enumerateInlineRanges(at depth: Int, block: (CSRange) -> Void) {
//        CSSymbolForeachInlineRangeAtDepth(symbolRef, Int32(depth)) { range in
//            block(range)
//        }
//    }

    public var range: CSRange {
        return CSSymbolGetRange(symbolRef)
    }

    public var name: String {
        guard let name = CSSymbolGetName(symbolRef) else {
            return "(unnamed)"
        }

        let string = String(cString: name)

        if string.count == 0 {
            return "(unnamed)"
        }

        return string
    }
    
    public func enumerateSoureInfo(_ block: (SourceInfo) -> Void) {
        withoutActuallyEscaping(block) { (block) in
            CSSymbolForeachSourceInfo(symbolRef) { (sourceInfoRef) in
                let sourceInfo = SourceInfo(sourceInfoRef: sourceInfoRef)

                block(sourceInfo)
            }
        }
    }
}
