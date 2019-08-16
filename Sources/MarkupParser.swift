// Markup
//
// Copyright (c) 2017 Guille Gonzalez
// See LICENSE file for license
//

import Foundation

public struct MarkupParser {
	public static func parse(text: String) -> [MarkupNode] {
		var parser = MarkupParser(text: text)
		return parser.parse()
	}

	private var tokenizer: MarkupTokenizer
	private var openingDelimiters: [(Int, UnicodeScalar)] = []
	var index = 0
	private init(text: String) {
		tokenizer = MarkupTokenizer(string: text)
	}

	private mutating func parse(recuseIndex: Int = 0) -> [MarkupNode] {
		var elements: [MarkupNode] = []
		let recursiveIndex = recuseIndex
		while let token = tokenizer.nextToken() {
			switch token {
			case .text(let text):
				elements.append(.text(text))

			case .leftDelimiter(let delimiter):
				// Recursively parse all the tokens following the delimiter
				index += 1
				openingDelimiters.append((recursiveIndex, delimiter))
				elements.append(contentsOf: parse(recuseIndex: recursiveIndex))

			case .rightDelimiter(let delimiter) where openingDelimiters.map { $0.1 }.contains(delimiter):
				guard let containerNode = close(delimiter: delimiter, elements: elements) else {
					fatalError("There is no MarkupNode for \(delimiter)")
				}
				return [containerNode]

			default:
				elements.append(.text(token.description))
			}
		}

		// Convert orphaned opening delimiters to plain text
		if let lastOrphan = openingDelimiters.last {
			if lastOrphan.0 == recursiveIndex {
				elements.insert(MarkupNode.text(String(lastOrphan.1)), at: 0)
				_ = openingDelimiters.popLast()
			}
		}

		return elements
	}

	private mutating func close(delimiter: UnicodeScalar, elements: [MarkupNode]) -> MarkupNode? {
		var newElements = elements

		// Convert orphaned opening delimiters to plain text
		while openingDelimiters.count > 0 {
			let openingDelimiter = openingDelimiters.popLast()!

			if openingDelimiter.1 == delimiter {
				break
			} else {
				newElements.insert(.text(String(openingDelimiter.1)), at: 0)
			}
		}

		return MarkupNode(delimiter: delimiter, children: newElements)
	}
}
