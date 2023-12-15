//
//  ChatView.swift
//  Aspri
//
//  Created by Narayana Wijaya on 15/12/23.
//

import SwiftUI
import SwiftData

struct ChatView: View {
    @Environment(\.modelContext) private var context
    @Environment(ChatData.self) private var chatData
    @Query private var chats: [ChatModel]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(chats) { chat in
                    Text(chat.text)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addItem() {
        Task {
            await chatData.addChat(context: context, "Hi, What do you think about Bali?")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                chatData.deleteChat(context: context, chat: chats[index])
            }
        }
    }
}

#Preview {
    ChatView()
        .modelContainer(for: ChatModel.self, inMemory: true)
}
