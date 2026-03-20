//
//  ChatGlobal.swift
//  binged
//
//  Created by Apprenant 92 on 19/03/2026.
//

import SwiftUI

struct ChatGlobal: View {
    
    @State private var newMessage = ""
    
    @State private var messages: [Message] = [
            Message(text: "Je sais plus quoi regarder 😩", isMe: true),
            Message(text: "T’as envie de quoi ?", isMe: false),
            Message(text: "Un truc comme Mindhunter, j’avais adoré", isMe: true),
            Message(text: "Ah ouais lourd 🔥 ambiance sombre et psychologie ?", isMe: false),
            Message(text: "Exactement, les dialogues, les tueurs, tout 😭", isMe: true),
            Message(text: "T’as vu True Detective ?", isMe: false),
            Message(text: "Oui déjà vu… saison 1 incroyable", isMe: true),
            Message(text: "Et Zodiac ou Dahmer ?", isMe: false),
            Message(text: "Vu aussi… j’ai l’impression d’avoir tout vu 😩", isMe: true),
            Message(text: "Hmm… Mindhunter c’est dur à remplacer", isMe: false),
            Message(text: "Grave, y’a rien au même niveau", isMe: true),
            Message(text: "T’as essayé Manhunt: Unabomber ?", isMe: false),
            Message(text: "Non, ça vaut le coup ?", isMe: true),
            Message(text: "Ouais très psychologie, interrogatoires, ambiance lourde", isMe: false),
            Message(text: "Ok ça peut me chauffer 👀", isMe: true),
            Message(text: "Sinon y’a The Sinner aussi", isMe: false),
            Message(text: "Déjà vu 😅", isMe: true),
            Message(text: "Ah ouais t’es chaud… bon courage 😂", isMe: false),
            Message(text: "merci Je vais plus passer 30 min à scroller pour rien", isMe: true),
            Message(text: "Derien", isMe: false)
    ]
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // 🔥 HEADER
                VStack(alignment: .leading) {
                    Text("Chat Global")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                }
                .padding()
                
                // 🔥 CHAT
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(messages) { message in
                                HStack {
                                    if message.isMe {
                                        Spacer()
                                        ChatBubble(text: message.text, isMe: true)
                                    } else {
                                        ChatBubble(text: message.text, isMe: false)
                                        Spacer()
                                    }
                                }
                                .id(message.id) // Important pour le scrollTo
                            }
                        }
                        .padding()
                    }
                    .onChange(of: messages.count) {
                        // Scroll en bas à chaque nouveau message
                        if let lastId = messages.last?.id {
                            withAnimation {
                                proxy.scrollTo(lastId, anchor: .bottom)
                            }
                        }
                    }
                    .onAppear {
                        // Scroll en bas à l'ouverture
                        if let lastId = messages.last?.id {
                            proxy.scrollTo(lastId, anchor: .bottom)
                        }
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
                    .disabled(newMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding()
                .background(Color("background"))
            }
        }
    }
    
    private func sendMessage() {
        let trimmed = newMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        let msg = Message(text: trimmed, isMe: true)
        messages.append(msg)
        newMessage = ""
    }
}

#Preview {
    ChatGlobal()
}
