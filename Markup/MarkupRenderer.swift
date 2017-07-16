//
//  MarkupRenderer.swift
//  Markup
//
//  Created by Guille Gonzalez on 12/07/2017.
//  Copyright © 2017 Tuenti Technologies S.L. All rights reserved.
//

import UIKit

public final class MarkupRenderer {
	private let baseFont: UIFont

	public init(baseFont: UIFont) {
		self.baseFont = baseFont
	}

	public func render(text: String) -> NSAttributedString {
		let elements = MarkupParser.parse(text: text)
		let attributes = [NSAttributedStringKey.font: baseFont]

		return elements.map { $0.render(withAttributes: attributes) }.joined()
	}
}

private extension MarkupNode {
	func render(withAttributes attributes: [NSAttributedStringKey: Any]) -> NSAttributedString {
		guard let currentFont = attributes[NSAttributedStringKey.font] as? UIFont else {
			fatalError("Missing font attribute in \(attributes)")
		}

		switch self {
		case .text(let text):
			return NSAttributedString(string: text, attributes: attributes)

		case .strong(let children):
			var newAttributes = attributes
			newAttributes[NSAttributedStringKey.font] = currentFont.addingSymbolicTraits(.traitBold)
			return children.map { $0.render(withAttributes: newAttributes) }.joined()

		case .emphasis(let children):
			var newAttributes = attributes
			newAttributes[NSAttributedStringKey.font] = currentFont.addingSymbolicTraits(.traitItalic)
			return children.map { $0.render(withAttributes: newAttributes) }.joined()

		case .delete(let children):
			var newAttributes = attributes
			newAttributes[NSAttributedStringKey.strikethroughStyle] = NSUnderlineStyle.styleSingle.rawValue
			newAttributes[NSAttributedStringKey.baselineOffset] = 0
			return children.map { $0.render(withAttributes: newAttributes) }.joined()
		}
	}
}

private extension Array where Element: NSAttributedString {
	func joined() -> NSAttributedString {
		let result = NSMutableAttributedString()
		for element in self {
			result.append(element)
		}
		return result
	}
}

private extension UIFont {
	func addingSymbolicTraits(_ traits: UIFontDescriptorSymbolicTraits) -> UIFont? {
		let newTraits = fontDescriptor.symbolicTraits.union(traits)
		guard let descriptor = fontDescriptor.withSymbolicTraits(newTraits) else {
			return nil
		}

		return UIFont(descriptor: descriptor, size: 0)
	}
}
