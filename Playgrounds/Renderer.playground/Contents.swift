import UIKit
import PlaygroundSupport
import Markup

let renderer = MarkupRenderer(baseFont: UIFont.systemFont(ofSize: 16))

let label = UILabel()
label.numberOfLines = 0
label.backgroundColor = UIColor.white
label.textColor = UIColor.black
label.attributedText = renderer.render(text: """
	The *quick*, ~red~ brown fox jumps over a _*lazy dog*_.
	Compute _6*4*8_. _Quick_zephyrs_blow_.
""")
label.sizeToFit()

PlaygroundPage.current.liveView = label
