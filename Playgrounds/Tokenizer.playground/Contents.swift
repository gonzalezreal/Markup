@testable import Markup

func dumpTokens(for input: String) {
	var tokenizer = MarkupTokenizer(string: input)

	print("Tokens for \"\(input)\"")
	while let token = tokenizer.nextToken() {
		print("\t\(token.debugDescription)")
	}
}

dumpTokens(for: "_Hello *world*_")
dumpTokens(for: "Hello *world")
dumpTokens(for: "Hello world*")
dumpTokens(for: "Hello * world")
