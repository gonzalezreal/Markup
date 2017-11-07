// Markup
//
// Copyright (c) 2017 Guille Gonzalez
// See LICENSE file for license
//

import UIKit
import Markup

class ViewController: UIViewController {
	@IBOutlet weak var plainTextLabel: UILabel!
	@IBOutlet weak var richTextLabel: UILabel!

	private let renderer = MarkupRenderer(baseFont: .systemFont(ofSize: 16))
	private let sampleText = "~Annihilate?~ No. No violence. I won't stand for it. _Not now, not ever, do you understand me?!_ *I'm the Doctor, the Oncoming Storm - and you basically meant beat them in a football match, didn't you?* I'm nobody's taxi service; I'm not gonna be there to catch you every time you feel like _*jumping out of a spaceship*_."

	override func viewDidLoad() {
		super.viewDidLoad()

		plainTextLabel.text = sampleText
		richTextLabel.attributedText = renderer.render(text: sampleText)
	}
}
