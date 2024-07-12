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
            if chatModel.isUser { Spacer() }
            
            VStack(alignment: .leading) {
                if !chatModel.isUser {
                    HStack {
                        Image("personal-assistant", bundle: nil)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(chatModel.isUser ? .clear : .gray)
                            }
                        Text("Chae")
                            .font(.title2)
                            .fontWeight(.bold)
                        .foregroundStyle(.indigo)
                    }
                }
                ForEach(getMarkdownResult()) { res in
                    if res.isCodeBlock {
                        CodeBlockView(markdownResult: res)
                            .padding(.bottom, 24)
                    } else {
                        Text(res.attributedText)
                    }
                }
            }
            .foregroundStyle(chatModel.isUser ? .white : .black)
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
    
    func getMarkdownResult() -> [MarkdownResult] {
        let document = Document(parsing: chatModel.text)
        var parser = MarkdownParser()
        let result = parser.markdownResults(from: document)
        print(chatModel.text)
        print(result)
        return result
    }
    
    func formattedText(text: String) -> AttributedString {
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
        return result ?? AttributedString("")
    }
}

#Preview {
    ScrollView {
//        ChatBubble(chatModel: ChatModel(text: "How are you?"))
//        ChatBubble(chatModel: ChatModel(text: """
//                                To scroll to the bottom of a `ScrollView` in SwiftUI, you can use the `scrollTo` modifier. Here's how:
//
//                                ```
//                                struct ContentView: View {
//                                    @State private var scrollToBottom = false
//
//                                    var body: some View {
//                                        ScrollView {
//                                            VStack {
//                                                // Your content here...
//                                            }
//                                            .frame(maxWidth: .infinity)
//                                        }
//                                        .scrollTo(scrollToBottom ? .bottom : nil)
//                        """, isUser: false))
        ChatBubble(chatModel: ChatModel(text: """
        ## Supported Platforms

        - iOS/tvOS 15 and above
        - macOS 12 and above
        - watchOS 8 and above
        - Linux

        ## Installation

        ### Swift Package Manager
        - File > Swift Packages > Add Package Dependency
        - Add https://github.com/alfianlosari/ChatGPTSwift.git

        ### Cocoapods
        ```ruby
        platform :ios, '15.0'
        use_frameworks!

        target 'MyApp' do
          pod 'ChatGPTSwift', '~> 1.3.1'
        end
        ```

        ## Requirement

        Register for API key from [OpenAI](https://openai.com/api). Initialize with api key

        ```swift
        let api = ChatGPTAPI(apiKey: "API_KEY")
        ```

        ## Usage

        There are 2 APIs: stream and normal

        ### Stream

        The server will stream chunks of data until complete, the method `AsyncThrowingStream` which you can loop using For-Loop like so:

        ```swift
        Task {
            do {
                let stream = try await api.sendMessageStream(text: "What is ChatGPT?")
                for try await line in stream {
                    print(line)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        ```

        ### Normal
        A normal HTTP request and response lifecycle. Server will send the complete text (it will take more time to response)

        ```swift
        Task {
            do {
                let response = try await api.sendMessage(text: "What is ChatGPT?")
                print(response)
            } catch {
                print(error.localizedDescription)
            }
        }
        ```
        """, isUser: false))
    }
}
