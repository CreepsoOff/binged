//  searchSerie.swift
//  binged
//
//  Created by Apprenant 92 on 16/03/2026.
//

import SwiftUI

struct SearchSerie: View {
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
        VStack(spacing: 0) {
            SearchBar(text: $searchText)
                .padding(.bottom, 15)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    if filteredSeries.isEmpty && !searchText.isEmpty {
                        Text("Aucun favori trouvé pour cette recherche.")
                            .foregroundStyle(.gray)
                            .padding(.top, 50)
                    } else {
                        LazyVGrid(columns: columns, spacing: 20){
                            ForEach(filteredSeries) { serie in
                                NavigationLink {
                                    SeriesDetailView(serie: serie)
                                } label: {
                                    VStack {
                                        if let url = serie.cover?.first?.thumbnails?.large?.url {
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
                                        } else {
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 100, height: 150)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .padding(.horizontal, 4)
                                        }
                                        
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
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }
            .refreshable {
                // Refresh des favoris (on re-synchronise avec le user)
                self.listSeries = user.favoriteSeriesSafe
                
                if let ids = user.favoriteSerieIDs {
                    for serieID in ids {
                        if let fetchedSerie = try? await vmSerie.getSerieById(serieID) {
                            if !listSeries.contains(where: { $0.name == fetchedSerie.name }) {
                                self.listSeries.append(fetchedSerie)
                            }
                        }
                    }
                }
            }
        }
        .task {
            self.listSeries = user.favoriteSeriesSafe
            
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
