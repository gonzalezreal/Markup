# Markup
[![CocoaPods](https://img.shields.io/cocoapods/v/Markup.svg)](https://cocoapods.org/pods/Markup)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platforms](https://img.shields.io/cocoapods/p/Markup.svg)](https://cocoapods.org/pods/Markup)

Markup generates attributed strings using a familiar markup syntax:

* To emphasize words or sentences, you can surround the text with \*asterisks\* to create bold text or \_underscores\_ for italic text.
* To show corrections in the text, surround the text with \~tildes\~ to strike out the text.
* You can combine formatting options.

For example, the following text:

```
The *quick*, ~red~ brown fox jumps over a _*lazy dog*_.
```

will be formatted like this:

The **quick**, ~red~ brown fox jumps over a ***lazy dog***.

Just to give you an idea, here is a screenshot of the sample application displaying the markup text and the resulting attributed string:

<p align="center">
    <img src="https://raw.githubusercontent.com/gonzalezreal/Markup/master/MarkupExample/Screenshot.png" width="50%" alt="Screenshot" />
</p>

## Examples
**Render an attributed string**

You can use `MarkupRenderer` to generate an attributed string from a given markup text:

```Swift
import Markup

let renderer = MarkupRenderer(baseFont: .systemFont(ofSize: 16))
let attributedText = renderer.render(text: "The *quick*, ~red~ brown fox jumps over a _*lazy dog*_.")
```

**Access the markup syntax tree**

Use `MarkupParser` to generate an abstract syntax tree for a markup text:

```Swift
let nodes = MarkupParser.parse(text: "The *quick*, ~red~ brown fox jumps over a _*lazy dog*_")
dump(nodes)

// Outputs:
[
  .text("The "),
  .strong([
    .text("quick")
  ]),
  .text(", "),
  .delete([
    .text("red")
  ]),
  .text(" brown fox jumps over a "),
  .emphasis([
    .strong([
       .text("lazy dog")
    ])
  ])
]
```

## Performance
Both the parsing and the rendering will take linear time to complete.

[This post](https://medium.com/makingtuenti/writing-a-lightweight-markup-parser-in-swift-5c8a5f0f793f) explains how Markup internally works, in case you are curious about the implementation.

## Installation
**Using CocoaPods**

Add `pod Markup` to your `Podfile`

**Using Carthage**

Add `github "gonzalezreal/Markup"` to your `Cartfile`

**Using the Swift Package Manager**

Add `Package(url: "https://github.com/gonzalezreal/Markup.git", majorVersion: 1)` to your `Package.swift` file.

**Swift compatibility**

- Version `2.2` supports `Swift 5.0`
- Version `2.1` supports `Swift 4.2`
- Version `2.0` supports `Swift 4`

## Help & Feedback
- [Open an issue](https://github.com/gonzalezreal/Markup/issues/new) if you need help, if you found a bug, or if you want to discuss a feature request.
- [Open a PR](https://github.com/gonzalezreal/Markup/pull/new/master) if you want to make some change to `Markup`.
- Contact [@gonzalezreal](https://twitter.com/gonzalezreal) on Twitter.
