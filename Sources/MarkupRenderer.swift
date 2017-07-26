#if os(iOS) || os(tvOS) || os(watchOS)
	import UIKit.UIFont
	public typealias Font = UIFont
#elseif os(OSX)
	import AppKit.NSFont
	public typealias Font = NSFont
#endif

public final class MarkupRenderer {
	private let baseFont: Font

	public init(baseFont: Font) {
		self.baseFont = baseFont
	}

	public func render(text: String) -> NSAttributedString {
		let elements = MarkupParser.parse(text: text)
		let attributes = [NSFontAttributeName: baseFont]

		return elements.map { $0.render(withAttributes: attributes) }.joined()
	}
}

private extension MarkupNode {
	func render(withAttributes attributes: [String: Any]) -> NSAttributedString {
		guard let currentFont = attributes[NSFontAttributeName] as? Font else {
			fatalError("Missing font attribute in \(attributes)")
		}

		switch self {
		case .text(let text):
			return NSAttributedString(string: text, attributes: attributes)

		case .strong(let children):
			var newAttributes = attributes
			newAttributes[NSFontAttributeName] = currentFont.boldFont()
			return children.map { $0.render(withAttributes: newAttributes) }.joined()

		case .emphasis(let children):
			var newAttributes = attributes
			newAttributes[NSFontAttributeName] = currentFont.italicFont()
			return children.map { $0.render(withAttributes: newAttributes) }.joined()

		case .delete(let children):
			var newAttributes = attributes
			newAttributes[NSStrikethroughStyleAttributeName] = NSUnderlineStyle.styleSingle.rawValue
			newAttributes[NSBaselineOffsetAttributeName] = 0
			return children.map { $0.render(withAttributes: newAttributes) }.joined()
		}
	}
}

extension Array where Element: NSAttributedString {
	func joined() -> NSAttributedString {
		let result = NSMutableAttributedString()
		for element in self {
			result.append(element)
		}
		return result
	}
}

#if os(iOS) || os(tvOS) || os(watchOS)
	extension UIFont {
		func boldFont() -> UIFont? {
			return addingSymbolicTraits(.traitBold)
		}

		func italicFont() -> UIFont? {
			return addingSymbolicTraits(.traitItalic)
		}

		func addingSymbolicTraits(_ traits: UIFontDescriptorSymbolicTraits) -> UIFont? {
			let newTraits = fontDescriptor.symbolicTraits.union(traits)
			guard let descriptor = fontDescriptor.withSymbolicTraits(newTraits) else {
				return nil
			}

			return UIFont(descriptor: descriptor, size: 0)
		}
	}
#elseif os(OSX)
	extension NSFont {
		func boldFont() -> NSFont? {
			return NSFontManager.shared().convert(self, toHaveTrait: .boldFontMask)
		}

		func italicFont() -> NSFont? {
			return NSFontManager.shared().convert(self, toHaveTrait: .italicFontMask)
		}
	}
#endif
