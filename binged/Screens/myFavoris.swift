//
//  myFavoris.swift
//  binged
//
//  Created by Apprenant 92 on 11/03/2026.
//

import SwiftUI

struct myFavoris: View {
    @State private var searchText = ""
    var user: User
        
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
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(user.favoriteGenre, id: \.id) { genre in
                            genreButton(genre: genre.name)
                        }
                    }
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
                        ForEach(user.favoriteActor) { actor in
                            actorBar(actor: actor)
                        }
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
                ForEach(user.favoriteSerie, id: \.id) { genre in
                    genreButton(genre: genre.name)
                }
            }
        }
    }
}
#Preview {
    myFavoris(user: magalie)
}
