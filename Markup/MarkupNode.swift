//
//  MarkupNode.swift
//  Markup
//
//  Created by Guille Gonzalez on 12/07/2017.
//  Copyright © 2017 Tuenti Technologies S.L. All rights reserved.
//

import Foundation

public enum MarkupNode {
	case plain(String)
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
