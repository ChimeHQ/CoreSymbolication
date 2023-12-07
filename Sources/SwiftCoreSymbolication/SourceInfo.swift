import Foundation
import CoreSymbolication

public class SourceInfo {
    private let sourceInfoRef: CSSourceInfoRef

    init(sourceInfoRef: CSSourceInfoRef) {
        self.sourceInfoRef = CSRetain(sourceInfoRef)
    }

    deinit {
        CSRelease(sourceInfoRef)
    }

    public var filePath: String {
        guard let name = CSSourceInfoGetPath(sourceInfoRef) else {
            return "(unnamed)"
        }

        let string = String(cString: name)

        if string.count == 0 {
            return "(unnamed)"
        }

        return string
    }

    public var sanitizedFilePath: String {
        let path = filePath

        guard path.hasPrefix("/Users/") else {
            return path
        }

        var parts = path.components(separatedBy: "/")

        parts[2] = "USER"

        return parts.joined(separator: "/")
    }

    public var lineNumber: UInt {
        return UInt(CSSourceInfoGetLineNumber(sourceInfoRef))
    }

    public var range: CSRange {
        return CSSourceInfoGetRange(sourceInfoRef)
    }
}
