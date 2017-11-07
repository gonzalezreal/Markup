// Markup
//
// Copyright (c) 2017 Guille Gonzalez
// See LICENSE file for license
//

import Foundation

public enum MarkupNode {
	case text(String)
	case strong([MarkupNode])
	case emphasis([MarkupNode])
	case delete([MarkupNode])
}

extension MarkupNode {
	init?(delimiter: UnicodeScalar, children: [MarkupNode]) {
		switch delimiter {
		case "*":
			self = .strong(children)
		case "_":
			self = .emphasis(children)
		case "~":
			self = .delete(children)
		default:
			return nil
		}
	}
}
