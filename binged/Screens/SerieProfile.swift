//
//  serieProffil.swift
//  binged
//
//  Created by Apprenant 92 on 10/03/2026.
//
import SwiftUI

struct SerieProfile: View {
    var serie: Serie
    
    var messages: [Message] = [
        Message(text: "Incroyable cette série 😍", isMe: true),
        Message(text: "Oui surtout la saison 1", isMe: false),
        Message(text: "mon personnage préféré c'est Skyler", isMe: true),
        Message(text: "oui elle est trop gentille", isMe: false)
    ]
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack{
                ZStack(alignment: .topLeading){
                    if let cover = serie.cover {
                        Image(cover)
                            .resizable()
                            .scaledToFill()
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
                    }
                }
                HStack{
                    Text("Plateformes :")
                        .foregroundColor(.white)
                    ForEach(serie.platform, id: \.name) { platform in
                        Logo(icon: platform.icon)
                    }
                    Spacer()
                    IconButton(text: "9,5", icon: "star.fill")

                }
                .padding(.horizontal, 8)
                .padding(.top, 8)
                HStack{
                    Text("Distribution")
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                        .bold()
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if serie.actors.isEmpty{
                            Text("il n'y a pas de série")
                                .foregroundColor(.white)
                        }
                        ForEach(serie.actors, id: \.actor?.name) { actor in
                            ActorBar(actor: actor.actor!)
                        }
                    }
                }
                    ZStack{
                        Color("background2")
                        ScrollView(showsIndicators: false) {
                        VStack{
                            VStack(alignment: .leading, spacing: 10){
                                Text("Synopsis")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .bold()
                                Text(serie.desc)
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                Color.background1.opacity(50)
                                    .cornerRadius(10))
                            
                            VStack(alignment: .leading, spacing: 10){
                                ScrollView {
                                    VStack(spacing: 12) {
                                        HStack{
                                            Text("Critique")
                                                .foregroundColor(.white)
                                                .font(.title2)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .bold()

                                    IconButton(text: "Chatter", icon: "text.bubble.fill")
                                        }
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
                                        }
                                    }
                                    .padding()
                                }
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                Color.background1.opacity(50)
                                    .cornerRadius(10))
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    SerieProfile(serie: MockData.breakingBad)
}
