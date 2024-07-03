//
//  ChatBubble.swift
//  Aspri
//
//  Created by Narayana Wijaya on 16/12/23.
//

import SwiftUI
import Markdown

struct ChatBubble: View {
    var chatModel: ChatModel
    
    var body: some View {
        HStack(alignment: .top) {
            if chatModel.isUser { Spacer() } else {
                Image("personal-assistant", bundle: nil)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(chatModel.isUser ? .clear : .gray)
                    }
            }
            Text(formattedText(text: chatModel.text)).foregroundStyle(chatModel.isUser ? .white : .black)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(chatModel.isUser ? Color.teal : Color.white).opacity(0.8)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(chatModel.isUser ? .clear : .gray)
                }
            if !chatModel.isUser { Spacer() }
        }
    }
    
    func formattedText(text: String) -> AttributedString {
        print("Original Text: ")
        print(text)
        print("------------------------")
        var result: AttributedString?
        
        do {
            result = try AttributedString(markdown: text,
                                          options: AttributedString.MarkdownParsingOptions(
                                            interpretedSyntax: .inlineOnlyPreservingWhitespace
                                          )
            )
        } catch {
            print(error.localizedDescription)
        }
        print("Formmatted text: ")
        print(result ?? AttributedString(""))
        print("------------------------------------------------------")
        return result ?? AttributedString("")
    }
    
    func formatUsingMarkdown(text: String) -> AttributedString {
        let doc = Document(parsing: text)
        var markdowner = Markdownosaur()
        let result = markdowner.attributedString(from: doc)
        return AttributedString(result.string)
    }
}

#Preview {
    VStack {
        ChatBubble(chatModel: ChatModel(text: "How are you?"))
        ChatBubble(chatModel: ChatModel(text: """
                                To scroll to the bottom of a `ScrollView` in SwiftUI, you can use the `scrollTo` modifier. Here's how:

                                ```
                                struct ContentView: View {
                                    @State private var scrollToBottom = false

                                    var body: some View {
                                        ScrollView {
                                            VStack {
                                                // Your content here...
                                            }
                                            .frame(maxWidth: .infinity)
                                        }
                                        .scrollTo(scrollToBottom ? .bottom : nil)
                        """, isUser: false))
    }
}
