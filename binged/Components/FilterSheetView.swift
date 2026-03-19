import SwiftUI

struct FilterSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(SerieViewModels.self) private var viewModel
    
    @Binding var selectedGenres: Set<GenreType>
    @Binding var selectedKinds: Set<Kind>
    @Binding var selectedDecades: Set<String>
    @Binding var yearRange: ClosedRange<Double>
    @Binding var inProgressOnly: Bool
    @Binding var selectedPlatforms: Set<String>
    
    private var lowerBoundBinding: Binding<Double> {
        Binding(
            get: { yearRange.lowerBound },
            set: { yearRange = min($0, yearRange.upperBound)...yearRange.upperBound }
        )
    }
    
    private var upperBoundBinding: Binding<Double> {
        Binding(
            get: { yearRange.upperBound },
            set: { yearRange = yearRange.lowerBound...max($0, yearRange.lowerBound) }
        )
    }
    
    private var hasActiveFilters: Bool {
        !selectedGenres.isEmpty || !selectedKinds.isEmpty || !selectedDecades.isEmpty || yearRange != 1940...2026 || inProgressOnly || !selectedPlatforms.isEmpty
    }
    
    private func resetFilters() {
        withAnimation {
            selectedGenres.removeAll()
            selectedKinds.removeAll()
            selectedDecades.removeAll()
            yearRange = 1940...2026
            inProgressOnly = false
            selectedPlatforms.removeAll()
        }
    }
    
    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Filtres")
                        .font(.title2).bold().foregroundStyle(.white)
                    
                    Spacer()
                    
                    if hasActiveFilters {
                        Button("Réinitialiser") {
                            resetFilters()
                        }
                        .font(.subheadline.bold())
                        .foregroundStyle(Design.accentColor)
                        .sensoryFeedback(.impact, trigger: hasActiveFilters)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 25)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 30) {
                        
                        Toggle("Séries en cours uniquement", isOn: $inProgressOnly)
                            .tint(Design.accentColor)
                            .foregroundStyle(.white)
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Text("Année de sortie")
                                    .font(.headline).foregroundStyle(.white)
                                Spacer()
                                Text("\(Int(yearRange.lowerBound)) — \(Int(yearRange.upperBound))")
                                    .font(.subheadline.monospacedDigit().bold())
                                    .foregroundStyle(Design.accentColor)
                            }
                            
                            RangeSlider(range: $yearRange, in: 1940...2026)
                                .padding(.horizontal, 14) // Pour laisser de la place aux curseurs
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Genres").font(.headline).foregroundStyle(.white)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(GenreType.allCases, id: \.self) { genre in
                                        FilterPill(title: genre.rawValue, isSelected: selectedGenres.contains(genre)) {
                                            toggleGenre(genre)
                                        }
                                    }
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Format").font(.headline).foregroundStyle(.white)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(Kind.allCases, id: \.self) { kind in
                                        FilterPill(title: kind.rawValue, isSelected: selectedKinds.contains(kind)) {
                                            toggleKind(kind)
                                        }
                                    }
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Plateforme").font(.headline).foregroundStyle(.white)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.allPlatforms) { plat in
                                        FilterPill(title: plat.name, isSelected: selectedPlatforms.contains(plat.name)) {
                                            togglePlatform(plat.name)
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    .padding()
                }
                
                Button {
                    dismiss()
                } label: {
                    Text("Voir les résultats")
                        .bold()
                        .foregroundStyle(Color("background"))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding()
            }
        }
    }
    
    private func toggleGenre(_ genre: GenreType) {
        if selectedGenres.contains(genre) {
            selectedGenres.remove(genre)
        } else {
            selectedGenres.insert(genre)
        }
    }
    
    private func toggleKind(_ kind: Kind) {
        if selectedKinds.contains(kind) {
            selectedKinds.remove(kind)
        } else {
            selectedKinds.insert(kind)
        }
    }
    
    private func togglePlatform(_ id: String) {
        if selectedPlatforms.contains(id) {
            selectedPlatforms.remove(id)
        } else {
            selectedPlatforms.insert(id)
        }
    }
}
