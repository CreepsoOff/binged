//  searchSerie.swift
//  binged
//
//  Created by Apprenant 92 on 16/03/2026.
//

import SwiftUI

struct SearchSerie: View {
    // On renomme la variable d'état pour éviter le conflit avec le nom de la struct
    @State private var searchText = ""
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var user: User
    
    @Environment(SerieViewModels.self) private var vmSerie
    
    @State private var listSeries: [Serie] = []
    
    var filteredSeries: [Serie] {
        if searchText.isEmpty {

            return listSeries
        }
        return listSeries.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        VStack { // J'ai ajouté un VStack pour bien séparer la searchBar du ScrollView
            SearchBar(text: $searchText) // Modifié ici
            
            ScrollView(showsIndicators: false) {
                HStack {
                    LazyVGrid(columns: columns, spacing: 20){
                        ForEach(filteredSeries) { serie in
                            if let url = serie.cover?.first?.thumbnails?.large?.url {
                                VStack {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 100, height: 150)
                                    .clipped()
                                    .padding(.horizontal, 4)
                                    Text(serie.name)
                                }
                            } else {
                                VStack {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 100, height: 150)
                                        .padding(.horizontal, 4)
                                    Text(serie.name)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal) // Un peu de padding pour faire respirer la liste
            }
        }
        .task {
            // 1. On synchronise d'abord avec les données locales du User
            self.listSeries = user.favoriteSeriesSafe
            
            // 2. Si la liste est vide mais qu'on a des IDs, on charge le reste
            if self.listSeries.isEmpty, let ids = user.favoriteSerieIDs {
                for serieID in ids {
                    do {
                        let fetchedSerie = try await vmSerie.getSerieById(serieID)
                        if !listSeries.contains(where: { $0.id == fetchedSerie.id }) {
                            self.listSeries.append(fetchedSerie)
                        }
                    } catch {
                        print("Erreur Airtable Actor: \(error)")
                    }
                }
            }
        }
    }
}

#Preview {
    SearchSerie(user: MockData.magalie)
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(PlayListViewModel())
        .environment(ActorViewModel())
}
