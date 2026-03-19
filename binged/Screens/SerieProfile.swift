//
//  SerieProfile.swift
//  binged
//
//  Created by Apprenant 92 on 10/03/2026.
//
import SwiftUI

struct SerieProfile: View {
    var serie: Serie
    
    // Les messages utilisent le type Message défini dans Models.swift
    let messages: [Message] = [
        Message(text: "Incroyable cette série 😍", isMe: true),
        Message(text: "Oui surtout la saison 1", isMe: false),
        Message(text: "mon personnage préféré c'est Skyler", isMe: true),
        Message(text: "oui elle est trop gentille", isMe: false)
    ]
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - 1. EN-TÊTE (COVER)
                ZStack(alignment: .bottomLeading){
                    if let url = serie.cover?.first?.thumbnails?.large?.url {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                        .clipped()
                        .overlay {
                            VStack{
                                Text(serie.name)
                                    .font(.system(size: 32))
                                    .foregroundColor(.white)
                                    .bold()
                                Spacer()
                                HStack{
                                    IconButton(text: "Trailer", icon: "play.fill")
                                    Spacer()
                                    IconButton(text: "Ajouter", icon: "plus")
                                }
                            }
                            .padding()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.black.opacity(0.0), .black.opacity(0.5)]), startPoint: .bottom, endPoint: .top)
                            )
                        }
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 300)
                    }
                }
                
                // MARK: - 2. INFOS PLATEFORMES
                HStack{
                    Text("Plateformes :")
                        .foregroundColor(.white)
                    ForEach(serie.platform, id: \.name) { platform in
                        Logo(attachments: platform.icon)
                    }
                    Spacer()
                    IconButton(text: "9,5", icon: "star.fill")

                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
                // MARK: - 3. DISTRIBUTION
                HStack{
                    Text("Distribution")
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                        .bold()
                }
                .padding(.horizontal, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        if serie.actors.isEmpty {
                            Text("Aucun acteur listé")
                                .foregroundColor(.gray)
                                .italic()
                        } else {
                            ForEach(serie.actors) { actorRole in
                                if let cast = actorRole.actor {
                                    NavigationLink {
                                        ActorProfileView(actor: cast)
                                    } label: {
                                        ActorBar(actor: cast)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                // MARK: - 4. CONTENU (SYNOPSIS & CRITIQUES)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20){
                        
                        // SYNOPSIS
                        VStack(alignment: .leading, spacing: 10){
                            Text("Synopsis")
                                .foregroundColor(.white)
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .bold()
                            Text(serie.desc)
                                .foregroundColor(.white)
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(20)
                        .background(Design.cardColor)
                        .cornerRadius(15)
                        
                        // CRITIQUES / CHAT
                        VStack(alignment: .leading, spacing: 10){
                            HStack{
                                Text("Critique")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .bold()

                                IconButton(text: "Chatter", icon: "text.bubble.fill")
                            }
                            
                            VStack(spacing: 12) {
                                ForEach(messages) { message in
                                    HStack {
                                        if message.isMe {
                                            Spacer()
                                            ChatBubble(chat: message.text, isMe: true)
                                        } else {
                                            ChatBubble(chat: message.text, isMe: false)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                        .padding(20)
                        .background(Design.cardColor)
                        .cornerRadius(15)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    SerieProfile(serie: MockData.breakingBad)
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(PlayListViewModel())
        .environment(ActorViewModel())
}
