//
//  AspriApp.swift
//  Aspri
//
//  Created by Narayana Wijaya on 15/12/23.
//

import SwiftUI
import SwiftData

@main
struct AspriApp: App {
    @Bindable private var chatData = ChatModelData()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ChatModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ChatView()
                .environment(chatData)
        }
        .modelContainer(sharedModelContainer)
    }
}
