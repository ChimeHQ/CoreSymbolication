import Foundation
import CoreSymbolication

public struct Architecture {
    let csArch: CSArchitecture

    init(arch: CSArchitecture) {
        self.csArch = arch
    }

    public var familyName: String {
        guard let name = CSArchitectureGetFamilyName(csArch) else {
            return "unknown"
        }

        return String(cString: name)
    }
}

extension Architecture: Hashable {
    public static func == (lhs: Architecture, rhs: Architecture) -> Bool {
        let lhsArch = lhs.csArch
        let rhsArch = rhs.csArch

        return lhsArch.cpu_type == rhsArch.cpu_type && lhsArch.cpu_subtype == rhsArch.cpu_subtype
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(csArch.cpu_type)
        hasher.combine(csArch.cpu_subtype)
    }
}

extension Architecture: CustomStringConvertible {
    public var description: String {
        return "\(familyName) (\(csArch.cpu_subtype))"
    }
}
