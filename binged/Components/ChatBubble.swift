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
            .background(isMe ? Color.blue : Color.gray.opacity(0.5))
            .foregroundColor(.white)
            .cornerRadius(12)
            .frame(maxWidth: 250, alignment: isMe ? .trailing : .leading)
    }
}

/*    var chat: String
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
}*/
