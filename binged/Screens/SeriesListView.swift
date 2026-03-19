import SwiftUI

// MARK: - 1. ÉCRAN PRINCIPAL (La Liste)
struct SeriesListView: View {
    @Environment(SerieViewModels.self) private var viewModel
    
    @State private var showFilters = false
    
    @State private var selectedGenres: Set<GenreType> = []
    @State private var selectedKinds: Set<Kind> = []
    @State private var selectedDecades: Set<String> = []
    @State private var yearRange: ClosedRange<Double> = 1940...2026
    @State private var inProgressOnly = false
    @State private var selectedPlatforms: Set<String> = []
    
    // Le tableau dynamique filtré !
    var filteredSeries: [Serie] {
        viewModel.series.filter { serie in
            let matchGenre = selectedGenres.isEmpty || selectedGenres.contains(serie.genre)
            let matchKind = selectedKinds.isEmpty || selectedKinds.contains(serie.type)
            let matchDecade = selectedDecades.isEmpty || selectedDecades.contains(serie.decennie)
            let matchYear = yearRange.contains(Double(serie.year))
            let matchProgress = !inProgressOnly || (serie.inProgress == true)
            
            let seriePlatformNames = serie.platformIDs?.compactMap { viewModel.platformIDToName[$0] } ?? []
            let matchPlatform = selectedPlatforms.isEmpty || seriePlatformNames.contains(where: { selectedPlatforms.contains($0) })
            
            return matchGenre && matchKind && matchDecade && matchYear && matchProgress && matchPlatform
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("background").ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("Séries")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Button {
                            showFilters.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                .font(.title)
                                .foregroundStyle(Design.accentColor)
                                .overlay(
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 10, height: 10)
                                        .offset(x: 10, y: -10)
                                        .opacity(hasActiveFilters ? 1 : 0)
                                )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Liste des séries
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView("Récupération des séries...")
                            .tint(.white)
                            .foregroundStyle(.secondary)
                        Spacer()
                    } else if filteredSeries.isEmpty {
                        Spacer()
                        VStack(spacing: 15) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 50))
                                .foregroundStyle(.gray)
                            Text("Aucune série ne correspond à tes filtres.")
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    } else {
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: 16) {
                                ForEach(filteredSeries) { serie in
                                    NavigationLink {
                                        SeriesDetailView(serie: serie)
                                    } label: {
                                        SerieRowCard(serie: serie)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                        }
                        .refreshable {
                            do {
                                try await viewModel.fetchLightSeries()
                                try await viewModel.fetchPlatforms()
                            } catch {
                                print("Erreur refresh: \(error)")
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showFilters) {
                FilterSheetView(
                    selectedGenres: $selectedGenres,
                    selectedKinds: $selectedKinds,
                    selectedDecades: $selectedDecades,
                    yearRange: $yearRange,
                    inProgressOnly: $inProgressOnly,
                    selectedPlatforms: $selectedPlatforms
                )
                .presentationDetents([.fraction(0.85), .large])
                .presentationDragIndicator(.visible)
            }
        }
        .task {
            do {
                try await viewModel.fetchLightSeries()
            } catch {
                print("Erreur: \(error)")
            }
            do {
                try await viewModel.fetchPlatforms()
            } catch {
                print("Erreur plateformes: \(error)")
            }
        }
    }
    
    // Vérifie si l'utilisateur a modifié au moins un filtre
    private var hasActiveFilters: Bool {
        !selectedGenres.isEmpty || !selectedKinds.isEmpty || !selectedDecades.isEmpty || yearRange != 1940...2026 || inProgressOnly || !selectedPlatforms.isEmpty
    }
}

#Preview {
    SeriesListView()
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(PlayListViewModel())
        .environment(ActorViewModel())
}
