//
//  ChatModelData.swift
//  Aspri
//
//  Created by Narayana Wijaya on 16/12/23.
//

import Foundation
import SwiftData
import GoogleGenerativeAI

@Observable
class ChatModelData {
    var prompth: String = ""
    var isLoading: Bool = false
    
    private var history = [
      ModelContent(role: "user", parts: "Hello, can you help me?"),
      ModelContent(role: "model", parts: "Great to meet you. How can I help you?"),
    ]
    
    func addChat(context: ModelContext) async {
        let userType = prompth
        prompth = ""
        
        context.insert(ChatModel(text: userType))
        let response = await sendChat(text: userType)
        
        context.insert(ChatModel(text: response, isUser: false))
        history.append(ModelContent(role: "user", userType))
        history.append(ModelContent(role: "model", response))
    }
    
    func deleteChat(context: ModelContext, chat: ChatModel) {
        context.delete(chat)
    }
    
    private func sendChat(text: String) async -> String {
        isLoading = true
        print("is loading: \(isLoading)")
        let config = GenerationConfig(
            temperature: 0.9,
            maxOutputTokens: 100
        )
        
        let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default, generationConfig: config)
        
        let chat = model.startChat(history: history)
        
        guard let response = try? await chat.sendMessage(text) else { return "" }
        
        isLoading = false
        print("is loading: \(isLoading)")
        if let text = response.text {
            print(text)
            return text
        }
        
        return ""
    }
}
