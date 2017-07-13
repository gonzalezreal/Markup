//
//  MarkupNode.swift
//  Markup
//
//  Created by Guille Gonzalez on 12/07/2017.
//  Copyright © 2017 Tuenti Technologies S.L. All rights reserved.
//

import Foundation

public enum MarkupNode {
	case plain(text: String)
	case strong(children: [MarkupNode])
	case emphasis(children: [MarkupNode])
	case delete(children: [MarkupNode])
}

extension MarkupNode {
	init?(delimiter: UnicodeScalar, children: [MarkupNode]) {
		switch delimiter {
		case "*":
			self = .strong(children: children)
		case "_":
			self = .emphasis(children: children)
		case "~":
			self = .delete(children: children)
		default:
			return nil
		}
	}
}
