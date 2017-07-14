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
	private var openingDelimiters: [UnicodeScalar] = []

	private init(text: String) {
		tokenizer = MarkupTokenizer(string: text)
	}
}

private extension MarkupParser {
	mutating func parse() -> [MarkupNode] {
		var elements: [MarkupNode] = []

		while let token = tokenizer.nextToken() {
			switch token {
			case .text(let text):
				elements.append(.plain(text))

			case .leftDelimiter(let delimiter):
				// Recursively parse all the tokens following the delimiter
				openingDelimiters.append(delimiter)
				elements.append(contentsOf: parse())

			case .rightDelimiter(let delimiter) where openingDelimiters.contains(delimiter):
				guard let containerNode = close(delimiter: delimiter, elements: elements) else {
					fatalError("There is no MarkupNode for \(delimiter)")
				}
				return [containerNode]

			default:
				elements.append(.plain(token.description))
			}
		}

		// Convert orphaned opening delimiters to plain text
		let plainElements: [MarkupNode] = openingDelimiters.map { .plain(String($0)) }
		elements.insert(contentsOf: plainElements, at: 0)
		openingDelimiters.removeAll()

		return elements
	}

	mutating func close(delimiter: UnicodeScalar, elements: [MarkupNode]) -> MarkupNode? {
		var newElements = elements

		// Convert orphaned opening delimiters to plain text
		while openingDelimiters.count > 0 {
			let openingDelimiter = openingDelimiters.popLast()!

			if openingDelimiter == delimiter {
				break
			} else {
				newElements.insert(.plain(String(openingDelimiter)), at: 0)
			}
		}

		return MarkupNode(delimiter: delimiter, children: newElements)
	}
}
