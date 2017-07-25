import XCTest
import Markup

private func equalDump<T>(_ lhs: T, _ rhs: T) -> Bool {
	var (ldump, rdump) = ("", "")
	dump(lhs, to: &ldump)
	dump(rhs, to: &rdump)

	return ldump == rdump
}

extension MarkupNode: Equatable {
	public static func == (lhs: MarkupNode, rhs: MarkupNode) -> Bool {
		return equalDump(lhs, rhs)
	}
}

class MarkupParserTests: XCTestCase {
	func testPlainText_parse_returnsPlainText() {
		// given
		let input = "hello $.;'there"
		let expected: [MarkupNode] = [
			.text("hello $.;'there")
		]

		// when
		let result = MarkupParser.parse(text: input)

		// then
		XCTAssertEqual(result, expected)
	}

	func testPlainTextWithSpecialCharacters_parse_returnsPlainText() {
		// given
		let input = "hello *_~ 🤡there"
		let expected: [MarkupNode] = [
			.text("hello "),
			.text("*"),
			.text("_"),
			.text("~"),
			.text(" 🤡there")
		]

		// when
		let result = MarkupParser.parse(text: input)

		// then
		XCTAssertEqual(result, expected)
	}

	func testLeftDelimiterWithoutRightDelimiter_parse_returnsPlainText() {
		// given
		let input = "Hello *foo bar"
		let expected: [MarkupNode] = [
			.text("Hello "),
			.text("*"),
			.text("foo bar")
		]

		// when
		let result = MarkupParser.parse(text: input)

		// then
		XCTAssertEqual(result, expected)
	}

	func testDelimitersEnclosedByPunctuation_parse_returnsFormattedText() {
		// given
		let input = "Hello.*Foo*!"
		let expected: [MarkupNode] = [
			.text("Hello."),
			.strong([
				.text("Foo")
			]),
			.text("!")
		]

		// when
		let result = MarkupParser.parse(text: input)

		// then
		XCTAssertEqual(result, expected)
	}

	func testDelimitersEnclosedByWhitespace_parse_returnsFormattedText() {
		// given
		let input = "Hello. *Foo* "
		let expected: [MarkupNode] = [
			.text("Hello. "),
			.strong([
				.text("Foo")
			]),
			.text(" ")
		]

		// when
		let result = MarkupParser.parse(text: input)

		// then
		XCTAssertEqual(result, expected)
	}

	func testDelimitersEnclosedByNewlines_parse_returnsFormattedText() {
		// given
		let input = "Hello.\n*Foo*\n"
		let expected: [MarkupNode] = [
			.text("Hello.\n"),
			.strong([
				.text("Foo")
			]),
			.text("\n")
		]

		// when
		let result = MarkupParser.parse(text: input)

		// then
		XCTAssertEqual(result, expected)
	}

	func testDelimitersAtBounds_parse_returnsFormattedText() {
		// given
		let input = "*Foo*"
		let expected: [MarkupNode] = [
			.strong([
				.text("Foo")
			])
		]

		// when
		let result = MarkupParser.parse(text: input)

		// then
		XCTAssertEqual(result, expected)
	}

	func testOpeningDelimiterEnclosedByDelimiters_parse_returnsFormattedText() {
		// given
		let input = "Hello *_world*_"
		let expected: [MarkupNode] = [
			.text("Hello "),
			.strong([
				.text("_"),
				.text("world")
			]),
			.text("_")
		]

		// when
		let result = MarkupParser.parse(text: input)

		// then
		XCTAssertEqual(result, expected)
	}

	func testIntrawordDelimiters_parse_intrawordDelimitersAreIgnored() {
		// given
		let input = "_1_2_3_"
		let expected: [MarkupNode] = [
			.emphasis([
				.text("1"),
				.text("_"),
				.text("2"),
				.text("_"),
				.text("3")
			])
		]

		// when
		let result = MarkupParser.parse(text: input)

		// then
		XCTAssertEqual(result, expected)
	}

	func testNestedDelimiters_parse_returnsNestedMarkup() {
		// given
		let input = "Hello ~*_world_*~!"
		let expected: [MarkupNode] = [
			.text("Hello "),
			.delete([
				.strong([
					.emphasis([
						.text("world")
					])
				])
			]),
			.text("!")
		]

		// when
		let result = MarkupParser.parse(text: input)

		// then
		XCTAssertEqual(result, expected)
	}
}
