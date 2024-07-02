//
//  ChatView.swift
//  Aspri
//
//  Created by Narayana Wijaya on 15/12/23.
//

import SwiftUI
import SwiftData
import Lottie

struct ChatView: View {
    @Environment(\.modelContext) private var context
    @Environment(ChatModelData.self) private var chatData
    @Query private var chats: [ChatModel]
    
    var body: some View {
        @Bindable var chatBindable = chatData
        
        NavigationSplitView {
            VStack {
                ScrollView {
                    ForEach(chats) { chat in
                        return ChatBubble(chatModel: chat)
                            .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            
                    }
                    .onDelete(perform: deleteItems)
                    
                    if chatData.isLoading {
                        HStack {
                            Image("personal-assistant", bundle: nil)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.gray)
                                }
                            
                            LottieView(name: LottieFiles.typing, loopMode: .loop, contentMode: .scaleAspectFit)
                                .frame(width: 75, alignment: .leading)
                            
                            Spacer()
                        }
                    }
                }
                .defaultScrollAnchor(.bottom)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            Image("personal-assistant", bundle: nil)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.gray)
                                }
                            VStack(alignment: .leading) {
                                Text("Chae")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                Text("Hi, please ask me anything!")
                                    .font(.caption2)
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(.bottom, 4)
                    }
                    //                    ToolbarItem(placement: .topBarTrailing) {
                    //                        Button {
                    //                            print("Speak with Aspri")
                    //                        } label: {
                    //                            Image(systemName: "person.wave.2.fill")
                    //                                .foregroundStyle(.white)
                    //                        }
                    //                    }
                }
                Spacer()
                HStack {
                    TextField("Enter prompth", text: $chatBindable.prompth, axis: .vertical)
                        .lineLimit(1...5)
                    Button(action: submit) {
                        Image(systemName: "paperplane.fill")
                    }
                }
                .padding()
            }
            .toolbarBackground(Color.teal, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        } detail: {
            Text("Select an item")
        }
    }
    
    private func submit() {
        Task {
            await chatData.addChat(context: context)
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
    let chatData = ChatModelData()
    chatData.isLoading = true
    return ChatView()
        .environment(chatData)
        .modelContainer(DataController.previewContainer)
}
