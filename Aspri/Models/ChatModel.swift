//
//  ChatModel.swift
//  Aspri
//
//  Created by Narayana Wijaya on 15/12/23.
//

import Foundation
import SwiftData
import GoogleGenerativeAI

@Model
final class ChatModel {
    var text: String
    
    init(text: String) {
        self.text = text
    }
}

@Observable class ChatData {
    
    func addChat(context: ModelContext, _ text: String) async {
        context.insert(ChatModel(text: text))
        let response = await sendChat(text: text)
        context.insert(ChatModel(text: response))
    }
    
    func deleteChat(context: ModelContext, chat: ChatModel) {
        context.delete(chat)
    }
    
    private func sendChat(text: String) async -> String {
        let config = GenerationConfig(maxOutputTokens: 100)
        
        let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default, generationConfig: config)
        
        let chat = model.startChat()
        
        guard let response = try? await chat.sendMessage(text) else { return "" }
        
        if let text = response.text {
            print(text)
            return text
        }
        
        return ""
    }
}
