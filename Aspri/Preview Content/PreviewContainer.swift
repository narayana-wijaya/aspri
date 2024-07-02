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
                                Jisoo, born Kim Ji-soo, is a South Korean singer and actress. She is a member of the girl group BLACKPINK, formed by YG Entertainment.
                                
                                Jisoo is known for her beauty and visuals, and has been ranked as one of the most beautiful women in the world by various publications. She has also been praised for her acting skills, and has starred in several dramas, including "Arthdal Chronicles" and "Snowdrop".

                                Jisoo is a talented and versatile artist,
                        """, isUser: false)
            
            container.mainContext.insert(chat)
            container.mainContext.insert(res)

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
