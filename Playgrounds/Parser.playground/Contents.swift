import Markup

var nodes = MarkupParser.parse(text: "The quick, ~red~ brown fox jumps over a _*lazy dog*_.")
dump(nodes)
print()

nodes = MarkupParser.parse(text: "Compute _6*4*8_. _Quick_zephyrs_blow_.")
dump(nodes)
print()

nodes = MarkupParser.parse(text: "Hello *_world*_")
dump(nodes)
