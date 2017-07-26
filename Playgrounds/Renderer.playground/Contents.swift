import Cocoa
import Markup

// You must build the Markup-macOS target to run this playground.

let renderer = MarkupRenderer(baseFont: .systemFont(ofSize: 16))
var attributedText = renderer.render(text: "The *quick*, ~red~ brown fox jumps over a _*lazy dog*_.")

attributedText = renderer.render(text: "Compute _6*4*8_. _Quick_zephyrs_blow_.")
