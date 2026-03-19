import SwiftUI

struct GenreResultsView: View {
    @Environment(SerieViewModels.self) private var serieVM
    let genre: GenreType
    
    // Configuration de la grille (2 colonnes) pour correspondre à SearchSeriesView
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var filteredSeries: [Serie] {
        serieVM.series.filter { $0.genre == genre }
    }
    
    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()
            
            VStack(spacing: 0) {
                if serieVM.isLoading {
                    Spacer()
                    ProgressView("Chargement des séries...")
                        .tint(.white)
                        .foregroundStyle(.white)
                    Spacer()
                } else if filteredSeries.isEmpty {
                    Spacer()
                    VStack(spacing: 15) {
                        Image(systemName: "film")
                            .font(.system(size: 50))
                            .foregroundStyle(.gray)
                        Text("Aucune série trouvée pour le genre \(genre.rawValue).")
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(filteredSeries) { serie in
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
                                            .lineLimit(1)
                                    }
                                    .padding(8)
                                    .background(Color.white.opacity(0.06))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 20)
                    }
                    .refreshable {
                        do {
                            try await serieVM.fetchLightSeries()
                        } catch {
                            print("Erreur refresh genre: \(error)")
                        }
                    }
                }
            }
        }
        .navigationTitle(genre.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .task {
            if serieVM.series.isEmpty {
                do {
                    try await serieVM.fetchLightSeries()
                } catch {
                    print("Erreur chargement: \(error)")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        GenreResultsView(genre: .crime)
            .environment(SerieViewModels())
            .environment(UserViewModel())
            .environment(PlayListViewModel())
            .environment(ActorViewModel())
    }
}
