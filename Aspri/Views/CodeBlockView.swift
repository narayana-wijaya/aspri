//
//  CodeBlockView.swift
//  Aspri
//
//  Created by Narayana Wijaya on 11/07/24.
//

import SwiftUI
import Markdown

enum HighlighterConstant {
    static let color = Color(red: 38/255, green: 38/255, blue: 38/255)
    static let bgColor = Color(red: 245/255, green: 245/255, blue: 240/255)
}

struct CodeBlockView: View {
    
    let markdownResult: MarkdownResult
    @State var isCopied = false
    
    var body: some View {
        VStack(alignment: .leading) {
            header
                .padding(.horizontal)
                .background(Color.gray)
            
            ScrollView(.horizontal, showsIndicators: true) {
                Text(markdownResult.attributedText)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .textSelection(.enabled)
            }
        }
        .background(.separator.opacity(0.2))
        .cornerRadius(8)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray.opacity(0.5))
        }
    }
    
    var header: some View {
        HStack {
            if let codeLanguage = markdownResult.codeLanguage {
                Text(codeLanguage.capitalized)
                    .font(.headline.monospaced())
                    .foregroundStyle(.white)
            }
            Spacer()
            button
                .padding(.vertical, 8)
        }
    }
    
    @ViewBuilder
    var button: some View {
        if isCopied {
            HStack {
                Text("Copied")
                    .foregroundStyle(.white)
                Image(systemName: "checkmark.circle.fill")
                    .imageScale(.large)
                    .symbolRenderingMode(.multicolor)
            }
            .frame(alignment: .trailing)
        } else {
            Button {
                let string = NSAttributedString(markdownResult.attributedText).string
                UIPasteboard.general.string = string
                withAnimation {
                    isCopied = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isCopied = false
                    }
                }
            } label: {
                Image(systemName: "doc.on.doc")
            }
            .foregroundStyle(.white.opacity(0.7))
        }
    }
}

#Preview {
    ScrollView {
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
        """, isUser: false))
        
        ChatBubble(chatModel: ChatModel(text:
        """
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
        """
                                        , isUser: false))
    }
}
