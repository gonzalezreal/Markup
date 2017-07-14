//
//  MarkupParserTests.swift
//  MarkupTests
//
//  Created by Guille Gonzalez on 12/07/2017.
//  Copyright © 2017 Tuenti Technologies S.L. All rights reserved.
//

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
			.plain("hello $.;'there")
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
			.plain("hello "),
			.plain("*"),
			.plain("_"),
			.plain("~"),
			.plain(" 🤡there")
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
			.plain("Hello "),
			.plain("*"),
			.plain("foo bar")
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
			.plain("Hello."),
			.strong([
				.plain("Foo")
			]),
			.plain("!")
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
			.plain("Hello. "),
			.strong([
				.plain("Foo")
			]),
			.plain(" ")
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
			.plain("Hello.\n"),
			.strong([
				.plain("Foo")
			]),
			.plain("\n")
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
				.plain("Foo")
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
			.plain("Hello "),
			.strong([
				.plain("_"),
				.plain("world")
			]),
			.plain("_")
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
				.plain("1"),
				.plain("_"),
				.plain("2"),
				.plain("_"),
				.plain("3")
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
			.plain("Hello "),
			.delete([
				.strong([
					.emphasis([
						.plain("world")
					])
				])
			]),
			.plain("!")
		]

		// when
		let result = MarkupParser.parse(text: input)

		// then
		XCTAssertEqual(result, expected)
	}
}
