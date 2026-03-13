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
                    Image("peaky_blinders_cover")
                        .resizable()
                        .scaledToFill()
                        .frame(width:400, height: 300)
                    VStack{
                        Text(serie.name)
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        HStack{
                            iconButton(text: "Trailer", icon: "play.fill")
                            Spacer()
                            Spacer()
                            iconButton(text: "Ajouter", icon: "plus")
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
//                    ForEach{
//                        (serie.platform) { Platform in
//                            iconButton(platform: platform)
//                        }
//                    }
                    logo(icon: "netflix")

                    logo(icon: "apple")
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
                        ForEach(serie.actors) { actor in
                            actorBar(actor: actor)
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

                            iconButton(text: "Rejoindre le chat", icon: "text.bubble.fill")
                                        .frame(maxWidth: .infinity, alignment: .leading)
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
    serieProffil(serie: series[9])
}
