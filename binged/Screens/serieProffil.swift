//
//  serieProffil.swift
//  binged
//
//  Created by Apprenant 92 on 10/03/2026.
//

import SwiftUI

struct serieProffil: View {
    var serie: Serie
    
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
                                        iconButton(text: "Trailer", icon: "play.fill")
                                        Spacer()
                                        iconButton(text: "Ajouter", icon: "plus")
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
                        logo(icon: platform.icon)
                    }
                    Spacer()
                    iconButton(text: "9,5", icon: "star.fill")

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
                            actorBar(actor: actor.actor!)
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
                                HStack{
                                    Text("Critique")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .bold()

                            iconButton(text: "Chatter", icon: "text.bubble.fill")
                                }
                                chatBubble(chat:"Yvette : sdjkfbksjdvbksjdbv")
                                chatBubble(chat:"Yvette : sdjkfbksjdvbksjdbv")
                                chatBubble(chat:"Yvette : sdjkfbksjdvbksjdbv fekjrnfkj fjklrejnfjk ferjkfnge")
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
    serieProffil(serie: MockData.breakingBad)
}
