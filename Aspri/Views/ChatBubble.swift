//
//  ChatBubble.swift
//  Aspri
//
//  Created by Narayana Wijaya on 16/12/23.
//

import SwiftUI

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
        var result: AttributedString?
        
        do {
            result = try AttributedString(markdown: text)
        } catch {
            print(error.localizedDescription)
        }
        
        return result ?? AttributedString("")
    }
}

#Preview {
    VStack {
        ChatBubble(chatModel: ChatModel(text: "How are you?"))
        ChatBubble(chatModel: ChatModel(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", isUser: false))
    }
}
