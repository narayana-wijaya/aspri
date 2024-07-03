//
//  PreviewContainer.swift
//  Aspri
//
//  Created by Narayana Wijaya on 16/12/23.
//

import SwiftData

@MainActor
class DataController {
    @MainActor
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: ChatModel.self, configurations: config)

            let chat = ChatModel(text: "Hello guys")
            let res = ChatModel(text: """
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
                        """, isUser: false)
            
            container.mainContext.insert(chat)
            container.mainContext.insert(res)

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
