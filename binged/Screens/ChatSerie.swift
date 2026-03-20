//
//  ChatSerie.swift
//  binged
//
//  Created by Apprenant 92 on 19/03/2026.
//

import SwiftUI

struct ChatSerie: View {

    @State private var newMessage = ""

    @State private var messages: [Message] = [
        Message(text: "Incroyable cette série 😍", isMe: true),
        Message(text: "Oui surtout la saison 1", isMe: false),
        Message(text: "La DA est folle", isMe: true),
        Message(text: "Grave !", isMe: false),
    ]

    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Arcane")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                }
                .padding()
                ZStack {
                    // 🔥 HEADER

                    Image("arcane_cover")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.2)  // ✅ OPACITÉ
                        .clipped()

                    // 🔥 CHAT
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(messages) { message in
                                HStack {
                                    if message.isMe {
                                        Spacer()
                                        ChatBubble(
                                            text: message.text,
                                            isMe: true
                                        )
                                    } else {
                                        ChatBubble(
                                            text: message.text,
                                            isMe: false
                                        )
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                // 🔥 INPUT
                HStack {
                    TextField("Message...", text: $newMessage)
                        .padding(10)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)

                    Button {
                        sendMessage()
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(
                        newMessage.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty
                    )
                }
                .padding()
                .background(Color("background"))
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }

    private func sendMessage() {
        let trimmed = newMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let msg = Message(text: trimmed, isMe: true)
        withAnimation {
            messages.append(msg)
            newMessage = ""
        }
    }
}

#Preview {
    ChatSerie()
}
