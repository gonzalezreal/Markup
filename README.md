# Markup
Markup is a simple text formatter written in Swift. It uses a syntax similar to the one you can find in apps like Slack or WhatsApp:

* To emphasize words or sentences, you can surround the text with \*asterisks\* to create bold text, or \_underscores\_ for italic text.
* To show corrections in the text, surround the text with \~tildes\~ to strike out the text.
* You can combine formatting options.

For example, the following text:

```
The *quick*, ~red~ brown fox jumps over a _*lazy dog*_.
```

will be formatted like this:

The **quick**, ~red~ brown fox jumps over a ***lazy dog***.

Another additional feature is that intra-world formatting is ignored. For example, the following text:

```
Compute _6*4*8_. _Quick_zephyrs_blow_.
```

will be formatted like this:

Compute _6\*4\*8_. _Quick\_zephyrs\_blow_.

## Usage
You can use the `MarkupRenderer` class to generate an `NSAttributedString` from a Markup text.

For example, this snippet:

```swift
import Markup

let renderer = MarkupRenderer(baseFont: UIFont.systemFont(ofSize: 16))

let label = UILabel()
label.numberOfLines = 0
label.backgroundColor = UIColor.white
label.textColor = UIColor.black
label.attributedText = renderer.render(text:
    """
    The *quick*, ~red~ brown fox jumps over a _*lazy dog*_.
    Compute _6*4*8_. _Quick_zephyrs_blow_.
    """
)
```

creates a label that will produce the following output:

![Renderer](https://cdn-images-1.medium.com/max/1600/1*REYpGzicXpSY4G8fI5J-PQ.png)
