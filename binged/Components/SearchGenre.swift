//
//  searchGenre.swift
//  binged
//
//  Created by Apprenant 92 on 13/03/2026.
//

import SwiftUI

struct SearchGenre: View {
    // On renomme la variable d'état pour éviter le conflit avec le nom de la struct
    @State private var searchText = ""
    var user: User
    
    var filteredGenres: [GenreType] {
        if searchText.isEmpty {
            // On utilise la nouvelle variable calculée 'favoriteGenres'
            return user.favoriteGenres
        }
        return user.favoriteGenres.filter {
            $0.rawValue.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        VStack { // J'ai ajouté un VStack pour bien séparer la searchBar du ScrollView
            SearchBar(text: $searchText) // Modifié ici
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(filteredGenres, id: \.self) { genre in
                        NavigationLink {
                            GenreResultsView(genre: genre)
                        } label: {
                            GenreButton(genre: genre.rawValue)
                        }
                    }
                }
                .padding(.horizontal) // Un peu de padding pour faire respirer la liste
            }
        }
    }
}

#Preview {
    SearchGenre(user: MockData.magalie)
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(PlayListViewModel())
        .environment(ActorViewModel())
}
