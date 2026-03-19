//
//  chatBubble.swift
//  binged
//
//  Created by Apprenant 92 on 11/03/2026.
//

import SwiftUI

struct ChatBubble: View {
    let text: String
    let isMe: Bool
    
    var body: some View {
        Text(text)
            .padding()
            .background(isMe ? Color.blue : Color.gray.opacity(0.3))
            .foregroundColor(.white)
            .cornerRadius(12)
            .frame(maxWidth: 250, alignment: isMe ? .trailing : .leading)
    }
}
