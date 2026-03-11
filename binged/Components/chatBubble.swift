//
//  chatBubble.swift
//  binged
//
//  Created by Apprenant 92 on 11/03/2026.
//

import SwiftUI

struct chatBubble: View {
    var chat: String
    
    var body: some View {
        Text(chat)
            .padding(12)
            .background(Color.background)
            .cornerRadius(20)
            .foregroundColor(.white)
    }
}


#Preview {
    chatBubble(chat: "Lorem Ipsum")
}
