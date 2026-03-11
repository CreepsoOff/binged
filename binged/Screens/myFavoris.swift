//
//  myFavoris.swift
//  binged
//
//  Created by Apprenant 92 on 11/03/2026.
//

import SwiftUI

struct myFavoris: View {
    @State private var searchText = ""
    
    var body: some View {
        ZStack{
            Color("background")
                .ignoresSafeArea()
            VStack{
                Text("Mes Favoris")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                Text("Genres")
                    .foregroundColor(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .bold()
                searchBar(text: $searchText)
                HStack{
                    genreButton(genre: "Science-fiction")
                    genreButton(genre: "Science")
                    genreButton(genre: "Action")
                }
                Text("Acteurs")
                    .foregroundColor(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .bold()
                searchBar(text: $searchText)
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
                HStack{
                    Text("Mes Séries à la une")
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .bold()
                    iconButton(text: "Mes playlists", icon: "list.number")
                }
                searchBar(text: $searchText)
            }
        }
    }
}
#Preview {
    myFavoris()
}
