import XCTest
@testable import CoreSymbolication

final class CoreSymbolicationTests: XCTestCase {
    func testLoggingLevelAvailability() {
        if #available(macOS 12.0, *) {
            _ = CSGetDebugLoggingLevel()
        }
    }
}
