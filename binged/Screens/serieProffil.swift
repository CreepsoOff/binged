//
//  serieProffil.swift
//  binged
//
//  Created by Apprenant 92 on 10/03/2026.
//

import SwiftUI

struct serieProffil: View {
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack{
                ZStack(alignment: .topLeading){
                    Image("peaky_blinders_cover")
                        .resizable()
                        .scaledToFill()
                        .frame(width:400, height: 200)
                    VStack{
                        Text("Peaky Blinders")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        HStack{
                            iconButton(text: "Trailer", icon: "play.fill")
                            Spacer()
                            iconButton(text: "Ajouter", icon: "plus")
                        }
                    }
                    .padding()
                    .frame(width: 400, height: 200)
                }
                Text("Distribution")
                    .foregroundColor(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .bold()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Image("pitt")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(
                                radius: 3,
                                x: 5,
                                y: 5
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(.white, lineWidth: 1)
                            )
                        Image("stone")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(
                                radius: 3,
                                x: 5,
                                y: 5
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(.white, lineWidth: 1)
                            )
                            .padding(5)
                    }
                }
                    ZStack{
                        Color("background2")
                        VStack{
                            VStack(alignment: .leading, spacing: 10){
                                Text("Synopsis")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .bold()
                                Text("Un professeur de chimie atteint d'un cancer s'associe à un ancien élève pour fabriquer et vendre de la méthamphétamine.")
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
                                genreButton(genre:"ffskdjfhsdkjfhskf")
                                genreButton(genre:"ffskdjfhsdkjfhskf")
                                genreButton(genre:"ffskdjfhsdkjfhskf")
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

#Preview {
    serieProffil()
}
