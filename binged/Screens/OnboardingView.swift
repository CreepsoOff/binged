//
//  OnboardingView.swift
//  binged
//
//  Created by apprenant85 on 18/03/2026.
//


import SwiftUI

struct OnboardingView: View {
    // MARK: - Variables d'état (Ce que l'utilisateur sélectionne)
    @State private var selectedGenres: Set<GenreType> = []
    @State private var selectedDecades: Set<String> = []
    @State private var selectedKinds: Set<Kind> = []
    
    var onCompletion: () -> Void
    
    let decades = ["1990s", "2000s", "2010s", "2020s"]
    
    let displayKinds: [Kind] = [.mini, .standard, .docuseries]

    let genreColumns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 4)

    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: - En-tête
                VStack(alignment: .leading, spacing: 8) {
                    Text("Bienvenue sur Binged !")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                    
                    Text("Personnalise ton expérience")
                        .font(.title3)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 30)
                
                // MARK: - Contenu Scrollable
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 35) {
                        
                        // --- SECTION 1 : GENRES ---
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Tes Genres")
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            // On affiche les 8 premiers genres pour correspondre à la maquette
                            let displayedGenres = Array(GenreType.allCases.prefix(8))
                            
                            LazyVGrid(columns: genreColumns, spacing: 15) {
                                ForEach(displayedGenres, id: \.self) { genre in
                                    FilterSquareButton(
                                        title: genre.rawValue,
                                        icon: genre.icon,
                                        isSelected: selectedGenres.contains(genre)
                                    ) {
                                        toggleSelection(for: genre, in: &selectedGenres)
                                    }
                                }
                            }
                        }
                        
                        // --- SECTION 2 : ANNÉES ---
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Tes Années Favorites")
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            HStack(spacing: 12) {
                                ForEach(decades, id: \.self) { decade in
                                    FilterPillButton(
                                        title: decade,
                                        isSelected: selectedDecades.contains(decade)
                                    ) {
                                        toggleSelection(for: decade, in: &selectedDecades)
                                    }
                                }
                            }
                        }
                        
                        // --- SECTION 3 : TYPES DE SÉRIES ---
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Type de Série")
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            HStack(spacing: 15) {
                                ForEach(displayKinds, id: \.self) { kind in
                                    FilterSquareButton(
                                        title: kind.rawValue,
                                        icon: kind.icon,
                                        isSelected: selectedKinds.contains(kind)
                                    ) {
                                        toggleSelection(for: kind, in: &selectedKinds)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                
                // MARK: - Bouton Continuer
                Button {
                    // TODO: Sauvegarder les préférences de l'utilisateur et changer d'écran
                    onCompletion()
                } label: {
                    Text("Continuer")
                        .font(.headline)
                        .foregroundStyle(Color("background")) // Texte foncé
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.white) // Fond blanc comme sur la maquette
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
        }
    }
    
    // MARK: - Fonction utilitaire pour cocher/décocher
    private func toggleSelection<T: Hashable>(for item: T, in set: inout Set<T>) {
        if set.contains(item) {
            set.remove(item)
        } else {
            set.insert(item)
        }
    }
}

// MARK: - Composants UI personnalisés (Boutons de filtre)

/// Bouton Carré (Pour les Genres et les Types)
struct FilterSquareButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title2)
                Text(title)
                    .font(.system(size: 11, weight: .medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .foregroundStyle(isSelected ? .white : .white.opacity(0.6))
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(isSelected ? Color.white.opacity(0.2) : Color.white.opacity(0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isSelected ? Color.white : Color.clear, lineWidth: 1.5)
            )
        }
    }
}

/// Bouton Pilule (Pour les Décennies)
struct FilterPillButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(isSelected ? .white : .white.opacity(0.6))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.white.opacity(0.2) : Color.white.opacity(0.05))
                )
                .overlay(
                    Capsule()
                        .stroke(isSelected ? Color.white : Color.clear, lineWidth: 1.5)
                )
        }
    }
}

// MARK: - Preview
#Preview {
    OnboardingView(onCompletion: {})
}
