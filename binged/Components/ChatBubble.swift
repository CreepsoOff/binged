//
//  ChatBubble.swift
//  binged
//
//  Created by Apprenant 92 on 11/03/2026.
//

import SwiftUI

struct ChatBubble: View {
    var chat: String
    var isMe: Bool
    
    var body: some View {
        Text(chat)
            .padding(12)
            .background(isMe ? Color("background2") : Color("background1"))
            .clipShape(.rect(cornerRadius: 20))
            .foregroundStyle(.white)
    }
}


#Preview {
    VStack {
        ChatBubble(chat: "Message de moi", isMe: true)
        ChatBubble(chat: "Message des autres", isMe: false)
    }
    .padding()
    .background(Color("background"))
}
