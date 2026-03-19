//
//  SearchSeriesView.swift
//  binged
//
//  Created by apprenant85 on 18/03/2026.
//


import SwiftUI

struct SearchSeriesView: View {
    @Environment(SerieViewModels.self) private var serieVM
    @State private var searchText = ""
    
    // 1. Filtrage dynamique en fonction de la barre de recherche
    var filteredSeries: [Serie] {
        if searchText.isEmpty {
            return serieVM.series
        } else {
            return serieVM.series.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    // 2. Configuration de la grille (2 colonnes)
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                // Ta couleur de fond personnalisée
                Color("background").ignoresSafeArea() 
                
                VStack(spacing: 15) {
                    
                        SearchBar(text: $searchText)
                    
                    if serieVM.isLoading {
                        Spacer()
                        ProgressView("Recherche des séries...")
                            .tint(.white)
                            .foregroundStyle(.white)
                        Spacer()
                    } else if filteredSeries.isEmpty {
                        Spacer()
                        Text("Aucune série ne correspond à votre recherche.")
                            .foregroundStyle(.gray)
                            .italic()
                        Spacer()
                    } else {
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(filteredSeries) { serie in
                                    // MARK: LE NAVIGATION LINK VERS LE DÉTAIL
                                    NavigationLink {
                                        SeriesDetailView(serie: serie)
                                    } label: {
                                        VStack(alignment: .leading, spacing: 8) {
                                            // L'Affiche
                                            if let url = serie.cover?.first?.thumbnails?.large?.url {
                                                AsyncImage(url: url) { image in
                                                    image
                                                        .resizable()
                                                        .aspectRatio(2/3, contentMode: .fill)
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 220)
                                                .clipped()
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .contentShape(RoundedRectangle(cornerRadius: 10))
                                                .padding(.bottom, 6)
                                            } else {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.gray.opacity(0.3))
                                                    .frame(maxWidth: .infinity)
                                                    .frame(height: 220)
                                                    .overlay {
                                                        Image(systemName: "tv")
                                                            .foregroundStyle(.white.opacity(0.5))
                                                    }
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                                    .contentShape(RoundedRectangle(cornerRadius: 10))
                                                    .padding(.bottom, 6)
                                            }
                                            
                                            // Le Titre
                                            Text(serie.name)
                                                .font(.headline)
                                                .bold()
                                                .foregroundStyle(.white)
                                                .lineLimit(1) // Pour ne pas casser la grille si le nom est long
                                        }
                                        .padding(8)
                                        .background(Color.white.opacity(0.06))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 20)
                        }
                        .refreshable {
                            do {
                                try await serieVM.fetchLightSeries()
                            } catch {
                                print("Erreur refresh search: \(error)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Recherche")
            .navigationBarTitleDisplayMode(.inline)
            // Pour forcer la couleur du titre dans la barre de navigation
            .toolbarColorScheme(.dark, for: .navigationBar) 
            .toolbarBackground(Color("background"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .environment(serieVM)
        // MARK: - LE FETCH "LIGHT" AU DÉMARRAGE
        .task {
            do {
                try await serieVM.fetchLightSeries()
            } catch {
                print("Erreur chargement des séries (Light): \(error)")
            }
        }
    }
}

#Preview {
    SearchSeriesView()
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(PlayListViewModel())
        .environment(ActorViewModel())
}
