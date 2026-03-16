//
//  myProffil.swift
//  binged
//
//  Created by Apprenant 92 on 06/03/2026.
//

import SwiftUI

struct myProffil: View {
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                Text("Mon Proffil")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                HStack {
                    Image("pitt")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .padding()
                    VStack {
                        Text(
                            "Acteur et producteur américain célèbre pour Fight Club, Seven et Once Upon a Time in Hollywood. Il a remporté plusieurs Oscars."
                        )
                        .foregroundColor(.white)
                        .lineLimit(8)
                        basicButton(text: "Modifier")
                    }
                }
                HStack {
                    Text("Mes Favoris")
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                    basicButton(text: "Modifier")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Text("Genres")
                    .foregroundColor(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        genreButton(genre: "Action")
                        genreButton(genre: "Policier")
                        genreButton(genre: "SF")
                        genreButton(genre: "Policier")
                        genreButton(genre: "Policier")
                        genreButton(genre: "Policier")
                        genreButton(genre: "Policier")
                    }
                }
                Text("Acteurs")
                    .foregroundColor(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
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
                Text("Série")
                    .foregroundColor(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
            }
        }
    }
}

#Preview {
    myProffil()
}
