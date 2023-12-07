import XCTest
@testable import SwiftCoreSymbolication

final class CoreSymbolicationTests: XCTestCase {
	func testSymbolicatorInterate() throws {
		let testDataURL = Bundle.module.resourceURL?.appendingPathComponent("TestData", isDirectory: true)
		let dSYMURL = try XCTUnwrap(testDataURL?.appendingPathComponent("InlineTest.app.dSYM"))
		let url = dSYMURL.appendingPathComponent("Contents/Resources/DWARF/InlineTest")

		let symbolicators = Symbolicator.symbolicators(at: url)

		XCTAssertEqual(symbolicators.count, 1)

		let owners = symbolicators.flatMap({ $0.symbolOwners })

		XCTAssertEqual(owners.count, 1)

		let owner = owners[0]

		XCTAssertEqual(owner.uuid, UUID(uuidString: "62450421-5420-3AF0-87CA-010FC8D6CEBA"))
		XCTAssertEqual(owner.architecture.familyName, "arm64")
	}
}
