//
//  ChatModel.swift
//  Aspri
//
//  Created by Narayana Wijaya on 15/12/23.
//

import Foundation
import SwiftData

@Model
final class ChatModel {
    var text: String
    var isUser: Bool
    var date: Date
    
    init(text: String, isUser: Bool = true, date: Date = Date()) {
        self.text = text
        self.isUser = isUser
        self.date = date
    }
}
