//
//  SerieProfile.swift
//  binged
//
//  Created by Apprenant 92 on 10/03/2026.
//

import SwiftUI

struct SerieProfile: View {
    var serie: Serie
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack{
                ZStack(alignment: .topLeading){
                    if let url = serie.cover?.first?.thumbnails?.large?.url {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width:400, height: 300)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width:400, height: 300)
                    }
                    VStack{
                        Text(serie.name)
                            .font(.system(size: 32))
                            .foregroundStyle(.white)
                            .bold()
                        Spacer()
                        HStack{
                            IconButton(text: "Trailer", icon: "play.fill")
                            Spacer()
                            Spacer()
                            IconButton(text: "Ajouter", icon: "plus")
                        }
                    }
                    .padding()
                    .frame(width: 400, height: 300)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.black.opacity(0.0), .black.opacity(0.5)]), startPoint: .bottom, endPoint: .top)
                    )
                }
                
                
                HStack{
                    Text("plateforme :")
                        .foregroundStyle(.white)
                    ForEach(serie.platform, id: \.name) { platform in
                        Logo(attachments: platform.icon)
                    }
                    Spacer()
                    IconButton(text: "9,5", icon: "star.fill")

                }
                .padding(.horizontal, 8)
                .padding(.top, 8)
                HStack{
                    Text("Distribution")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                        .bold()
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if serie.actors.isEmpty{
                            Text("il n'y a pas de série")
                                .foregroundStyle(.white)
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
                                    .foregroundStyle(.white)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .bold()
                                Text(serie.desc)
                                    .foregroundStyle(.white)
                                    .font(.title3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                Color.background1.opacity(50)
                                    .clipShape(.rect(cornerRadius: 10)))
                            
                            VStack(alignment: .leading, spacing: 10){
                                HStack{
                                    Text("Critique")
                                        .foregroundStyle(.white)
                                        .font(.title2)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .bold()

                            IconButton(text: "Chatter", icon: "text.bubble.fill")
                                }
                                ChatBubble(chat:"Yvette : sdjkfbksjdvbksjdbv")
                                ChatBubble(chat:"Yvette : sdjkfbksjdvbksjdbv")
                                ChatBubble(chat:"Yvette : sdjkfbksjdvbksjdbv fekjrnfkj fjklrejnfjk ferjkfnge")
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                Color.background1.opacity(50)
                                    .clipShape(.rect(cornerRadius: 10)))
                            
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
