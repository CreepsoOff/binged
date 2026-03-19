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
        VStack {
            // Search bar at the top
            SearchBar(text: $searchText)

            // Grid of series inside a ScrollView
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(filteredSeries) { serie in
                        NavigationLink {
                            SeriesDetailView(serie: serie)
                        } label: {
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
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.horizontal, 4)

                                    Text(serie.name)
                                        .font(.caption)
                                        .bold()
                                        .foregroundStyle(.white)
                                        .lineLimit(1)
                                }
                            } else {
                                VStack {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 100, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .padding(.horizontal, 4)

                                    Text(serie.name)
                                        .font(.caption)
                                        .bold()
                                        .foregroundStyle(.white)
                                        .lineLimit(1)
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
                        if !listSeries.contains(where: { $0.name == fetchedSerie.name }) {
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
