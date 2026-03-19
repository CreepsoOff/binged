//
//  ProfileCarouselView.swift
//  binged
//
//  Created by apprenant85 on 17/03/2026.
//


import SwiftUI

struct ProfileCarouselView: View {
    // La liste de tes séries favorites
    var series: [Serie]
    
    // L'index de la série actuellement au centre
    @State private var currentIndex: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            
            // MARK: - 1. EN-TÊTE
            HStack {
                Text("Séries")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                
                Spacer()
                
                // BOUTON PLAYLISTS
                Button {
                    // TODO: Navigation vers l'écran des playlists
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "text.book.closed.fill")
                        Text("Mes Playlists")
                            .bold()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.orange) // Ou ta couleur Design.accentColor
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal)

            // MARK: - 2. LE CARROUSEL
            if series.isEmpty {
                Text("Aucune série favorite pour le moment.")
                    .italic()
                    .foregroundStyle(.gray)
                    .frame(height: 300)
            } else {
                GeometryReader { geo in
                    let width = geo.size.width
                    
                    ZStack {
                        // CARTE DE GAUCHE (Uniquement s'il y a 2 séries ou plus)
                        if series.count >= 2 {
                            // Le modulo (%) permet de boucler à l'infini
                            let leftIndex = (currentIndex - 1 + series.count) % series.count
                            
                            ProfileCarouselCard(serie: series[leftIndex], isCenter: false, isLeft: true)
                                .offset(x: -width * 0.30) // Pousse la carte à gauche
                                .onTapGesture {
                                    slide(to: leftIndex)
                                }
                        }
                        
                        // CARTE DE DROITE (Uniquement s'il y a 3 séries ou plus)
                        if series.count >= 3 {
                            let rightIndex = (currentIndex + 1) % series.count
                            
                            ProfileCarouselCard(serie: series[rightIndex], isCenter: false, isLeft: false)
                                .offset(x: width * 0.30) // Pousse la carte à droite
                                .onTapGesture {
                                    slide(to: rightIndex)
                                }
                        }
                        
                        // CARTE CENTRALE
                        ProfileCarouselCard(serie: series[currentIndex], isCenter: true, isLeft: false)
                            .offset(x: 0)
                            // GESTION DU SWIPE (Glissement au doigt)
                            .gesture(
                                DragGesture()
                                    .onEnded { value in
                                        let threshold: CGFloat = 30
                                        if value.translation.width > threshold && series.count >= 2 {
                                            // Swipe vers la droite -> Précédent
                                            slide(to: (currentIndex - 1 + series.count) % series.count)
                                        } else if value.translation.width < -threshold && series.count >= 2 {
                                            // Swipe vers la gauche -> Suivant
                                            slide(to: (currentIndex + 1) % series.count)
                                        }
                                    }
                            )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(height: 350) // La hauteur allouée à ton composant
            }
        }
    }
    
    // Fonction utilitaire pour l'animation
    private func slide(to index: Int) {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            currentIndex = index
        }
    }
}
#Preview("Carrousel Podium") {
    // 1. Création de données factices (Mock) pour la preview
    let mockSerie1 = Serie(
        name: "Série 1",
        desc: "Description 1",
        type: .standard,
        cover: [MockData.mockAttachment], // Mise à jour type [Attachment]
        year: 2008,
        decennie: "2000s",
        genre: .drama,
        nbSaisons: 5,
        nbEpisodes: 62
    )
    
    let mockSerie2 = Serie(
        name: "Série 2",
        desc: "Description 2",
        type: .standard,
        cover: [MockData.mockAttachment], // Mise à jour type [Attachment]
        year: 2016,
        decennie: "2010s",
        genre: .sf,
        nbSaisons: 4,
        nbEpisodes: 34
    )
    
    let mockSerie3 = Serie(
        name: "Série 3",
        desc: "Description 3",
        type: .standard,
        cover: [MockData.mockAttachment], // Mise à jour type [Attachment]
        year: 2011,
        decennie: "2010s",
        genre: .fantasy,
        nbSaisons: 8,
        nbEpisodes: 73
    )
    
    // 2. Affichage avec un fond sombre pour bien voir le rendu
    return ZStack {
        // Remplace par la couleur de fond de ton app (ex: Design.bgColor)
        Color(red: 0.1, green: 0.1, blue: 0.15)
            .ignoresSafeArea()
        
        ProfileCarouselView(series: [mockSerie1, mockSerie2, mockSerie3])
    }
}
