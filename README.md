# Markup
![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg)
[![Platforms](https://img.shields.io/cocoapods/p/Markup.svg)](https://cocoapods.org/pods/Markup)
[![Swift Package Manager](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/v/Markup.svg)](https://cocoapods.org/pods/Markup)
[![Twitter: @gonzalezreal](https://img.shields.io/badge/twitter-@gonzalezreal-blue.svg?style=flat)](https://twitter.com/gonzalezreal)

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

[This post](https://gonzalezreal.github.io/2017/07/20/writing-a-lightweight-markup-parser-in-swift.html) explains how Markup internally works, in case you are curious about the implementation.

## Installation
**Using the Swift Package Manager**

Add Markup as a dependency to your `Package.swift` file. For more information, see the [Swift Package Manager documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).

```
.package(url: "https://github.com/gonzalezreal/Markup", from: "2.3.0")
```

**Using Carthage**

Add `github "gonzalezreal/Markup"` to your `Cartfile`

**Using CocoaPods**

Add `pod Markup` to your `Podfile`

## Help & Feedback
- [Open an issue](https://github.com/gonzalezreal/Markup/issues/new) if you need help, if you found a bug, or if you want to discuss a feature request.
- [Open a PR](https://github.com/gonzalezreal/Markup/pull/new/master) if you want to make some change to `Markup`.
- Contact [@gonzalezreal](https://twitter.com/gonzalezreal) on Twitter.
