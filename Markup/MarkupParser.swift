//
//  MarkupParser.swift
//  Markup
//
//  Created by Guille Gonzalez on 12/07/2017.
//  Copyright © 2017 Tuenti Technologies S.L. All rights reserved.
//

import Foundation

public struct MarkupParser {
	public static func parse(text: String) -> [MarkupNode] {
		var parser = MarkupParser(text: text)
		return parser.parse()
	}

	private var tokenizer: MarkupTokenizer

	private init(text: String) {
		tokenizer = MarkupTokenizer(string: text)
	}
}

private extension MarkupParser {
	mutating func parse() -> [MarkupNode] {
		var elements: [MarkupNode] = []

		while let token = tokenizer.nextToken() {
			switch token {
			case .text(let value):
				elements.append(.plain(text: value))
			case .leftDelimiter(let value):
				elements.append(contentsOf: parse(delimiter: value))
			default:
				elements.append(.plain(text: token.description))
			}
		}

		return elements
	}

	mutating func parse(delimiter: UnicodeScalar) -> [MarkupNode] {
		var elements: [MarkupNode] = []
		var isClosed = false

		while let token = tokenizer.nextToken() {
			if token == .rightDelimiter(delimiter) {
				isClosed = true
				break
			}

			switch token {
			case .text(let value):
				elements.append(.plain(text: value))
			case .leftDelimiter(let value):
				elements.append(contentsOf: parse(delimiter: value))
			default:
				elements.append(.plain(text: token.description))
			}
		}

		if isClosed {
			guard let parentNode = MarkupNode(delimiter: delimiter, children: elements) else {
				fatalError("Delimiter '\(delimiter)' is not supported")
			}
			return [parentNode]
		} else {
			// Left delimiter without a corresponding right delimiter
			elements.insert(.plain(text: String(delimiter)), at: 0)
			return elements
		}
	}
}
