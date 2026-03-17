import SwiftUI


struct SeriesDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let serie: Serie
    let textSecondary = Color.white.opacity(0.6)
    
    @State private var showPlaylistPicker = false
    
    

    var body: some View {
        ZStack {
            Design.bgColor.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // MARK: - 1. AFFICHE
                    if let coverName = serie.cover {
                        Image(coverName)
                            .resizable()
                            .scaledToFill()
                            .containerRelativeFrame(.horizontal)
                            .frame(height: Design.coverHeight, alignment: .top)
                            .overlay(alignment: .bottom) {
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, Design.bgColor]),
                                    startPoint: .center,
                                    endPoint: .bottom
                                )
                            }
                            .overlay(alignment: .bottom) {
            
                                HStack {
                                    Button {
                                        /// Fonction pour le trailer à faire
                                        print("Lancement du trailer pour \(serie.name)")
                                    } label: {
                                        IconButton(text: "Trailer", icon: "play.fill")
                                    }
                                    
                                    Spacer()
                                    
                                    Button {
                                        showPlaylistPicker.toggle()
                                    } label: {
                                        IconButton(text: "Ajouter", icon: "plus")
                                    }
                                }
                                .padding()
                            }
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Design.cardColor)
                            .frame(height: Design.coverHeight)
                            .overlay {
                                Text("Pas d'image").foregroundStyle(textSecondary)
                            }
                    }

                    VStack(alignment: .leading) {
                        
                        // MARK: - 2. TITRE & PLATEFORMES
                        VStack(alignment: .leading, spacing: 8) {
                            Text(serie.name)
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.white)
                            
                            HStack {
                                Text("Plateformes :")
                                    .font(.caption)
                                    .foregroundStyle(textSecondary)
                                
                                ForEach(serie.platform) { platform in
                                    Logo(icon: platform.icon)
                                    
                                }
                            }
                        }
                        .padding(.bottom, 10)
                        
                        // MARK: - 3. MÉTADONNÉES
                        HStack(spacing: 15) {
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.orange)
                                Text("9.9")
                                    .bold()
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(.orange.opacity(0.2))
                            .clipShape(Capsule())
                            
                            Text("• \(String(serie.year)) • \(serie.nbSaisons) \(serie.nbSaisons <= 1 ? "Saison" : "Saisons")")
                                .foregroundStyle(textSecondary)
                            
                            if serie.inProgress == true {
                                Spacer()
                                
                                Text("EN COURS")
                                    .font(.system(size: 10, weight: .heavy))
                                    .foregroundStyle(Design.accentColor)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Design.accentColor.opacity(0.15))
                                    .clipShape(Capsule())
                                    .overlay(
                                        Capsule().stroke(Design.accentColor.opacity(0.3), lineWidth: 1)
                                    )
                            }
                        }
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .padding(.bottom)

                        // MARK: - 4. DISTRIBUTION
                        Text("Distribution")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)
                        
                        let validActorRoles = serie.actors.compactMap { $0 }
                        
                        if !validActorRoles.isEmpty {
                            ScrollView(.horizontal) {
                                HStack(alignment: .top) {
                                    ForEach(validActorRoles, id: \.id) { actorRole in
                                        if let currentActor = actorRole.actor {
                                            NavigationLink {
                                                ActorProfileView(actor: currentActor)
                                            } label: {
                                                VStack {
                                                    Spacer()
                                                    Circle()
                                                        .fill(Design.cardColor)
                                                        .frame(width: 70, height: 70)
                                                        .overlay {
                                                            if let imageName = currentActor.imageName {
                                                                Image(imageName)
                                                                    .resizable()
                                                                    .scaledToFill()
                                                                    .clipShape(Circle())
                                                            }
                                                        }
                                                        .overlay {
                                                            Circle().stroke(Design.accentColor, lineWidth: 2)
                                                        }

                                                    Text(currentActor.name)
                                                        .font(.caption)
                                                        .bold()
                                                        .foregroundStyle(.white)
                                                        .lineLimit(1)

                                                    Text(actorRole.roleName)
                                                        .font(.caption2)
                                                        .foregroundStyle(textSecondary)
                                                        .lineLimit(1)
                                                }
                                                .frame(width: 80)
                                            }
                                        }
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                            .padding(.bottom)
                        }

                        // MARK: - 5. SYNOPSIS (Design Écran 2)
                        if !serie.desc.isEmpty {
                            Text("Synopsis")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(.white)

                            Text(serie.desc)
                                .font(.body)
                                .foregroundStyle(textSecondary)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Design.cardColor)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .padding(.bottom)
                        }

                        // MARK: - 6. CRITIQUES & BOUTON CHAT
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Critiques")
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(.white)
                                
                                Spacer()
                                
                                // BOUTON CHATTER
                                NavigationLink {
                                    /// (FAIRE CHAT SERIE ICI)
                                } label: {
                                    IconButton(text: "Chatter", icon: "text.bubble.fill")
                                }
                            }

                            VStack(spacing: 12) {
                                if serie.reviews.isEmpty {
                                    Text("Soyez le premier à laisser une critique !")
                                        .font(.caption)
                                        .italic()
                                        .foregroundStyle(textSecondary)
                                        .padding()
                                } else {
                                    ForEach(serie.reviews) { review in
                                        HStack(alignment: .top) {
                                            Text("\(review.user) :")
                                                .bold()
                                                .foregroundStyle(.white)
                                            Text(review.text)
                                                .foregroundStyle(textSecondary)
                                            Spacer()
                                        }
                                        .padding()
                                        .background(Design.innerCardColor)
                                        .clipShape(.rect(cornerRadius: 12))
                                    }
                                }
                            }
                            .padding()
                            .background(Design.cardColor)
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.bottom, 40)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea(edges: .top)
        }
        .navigationBarTitleDisplayMode(.inline)
        /// Ecran de sélection des playlists (à venir)
        .sheet(isPresented: $showPlaylistPicker) {
            Text("Interface de sélection des Playlists (A venir)")
                .presentationDetents([.medium])
        }
    }
}

// MARK: - Preview Live Airtable
#Preview("Test Live Séries") {
    
    struct LiveSeriesListPreview: View {
        @State private var viewModel = SerieViewModels()
        
        var body: some View {
            NavigationStack {
                Group {
                    if viewModel.isLoading {
                        VStack(spacing: 16) {
                            ProgressView()
                            Text("Récupération séries")
                                .foregroundStyle(.secondary)
                        }
                    } else if viewModel.series.isEmpty {
                        Text("Aucune série trouvée")
                            .foregroundStyle(.secondary)
                    } else {
                        List(viewModel.series) { serie in
                            NavigationLink {
                                SeriesDetailView(serie: serie)
                            } label: {
                                HStack(spacing: 12) {
                                    if let cover = serie.cover {
                                        Image(cover)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 45, height: 65)
                                            .clipShape(.rect(cornerRadius: 6))
                                    } else {
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(Design.cardColor)
                                            .frame(width: 45, height: 65)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(serie.name)
                                            .font(.headline)
                                            .foregroundStyle(.primary)
                                        
                                        Text("\(String(serie.year)) • \(serie.genre.rawValue)")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                .navigationTitle("Séries")
            }
            .environment(viewModel)
            .task {
                do {
                    try await viewModel.fetchSeries()
                } catch {
                    print("Erreur Preview Séries: \(error)")
                }
            }
        }
    }
    
    return LiveSeriesListPreview()
}
