//
//  ChatBubble.swift
//  binged
//
//  Created by Apprenant 92 on 11/03/2026.
//

import SwiftUI

struct ChatBubble: View {
    var chat: String
    
    var body: some View {
        Text(chat)
            .padding(12)
            .background(Color.background)
            .clipShape(.rect(cornerRadius: 20))
            .foregroundStyle(.white)
    }
}


#Preview {
    ChatBubble(chat: "Lorem Ipsum")
}
