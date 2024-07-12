//
//  MarkdownResult.swift
//  Aspri
//
//  Created by Narayana Wijaya on 11/07/24.
//

import Foundation

struct MarkdownResult: Identifiable {
    let id = UUID()
    let attributedText: AttributedString
    let isCodeBlock: Bool
    let codeLanguage: String?
}
