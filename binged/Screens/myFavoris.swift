//
//  myFavoris.swift
//  binged
//
//  Created by Apprenant 92 on 11/03/2026.
//

import SwiftUI

struct myFavoris: View {
    @State private var searchGenre = ""
    @State private var searchActor = ""
    @State private var searchSerie = ""
    
    var user: User
    
    var filteredGenres: [Genre] {
            if searchGenre.isEmpty {
                return user.favoriteGenre
            }
            return user.favoriteGenre.filter {
                $0.name.localizedCaseInsensitiveContains(searchGenre)
            }
        }
        
        var filteredActors: [Actor] {
            if searchActor.isEmpty {
                return user.favoriteActor
            }
            return allActors.filter {
                $0.actorFirstName.localizedCaseInsensitiveContains(searchActor)
            }
        }
        
        var filteredSeries: [Serie] {
            if searchSerie.isEmpty {
                return user.favoriteSerie
            }
            return user.favoriteSerie.filter {
                $0.name.localizedCaseInsensitiveContains(searchSerie)
            }
        }
        
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
                searchBar(text: $searchGenre)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(filteredGenres, id: \.id) { genre in
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
                searchBar(text: $searchActor)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(filteredActors) { actor in
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
                searchBar(text: $searchSerie)
                ForEach(filteredSeries, id: \.id) { serie in
                    genreButton(genre: serie.name)
                }
            }
        }
    }
}
#Preview {
    myFavoris(user: magalie)
}
