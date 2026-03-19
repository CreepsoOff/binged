import SwiftUI

struct SeriesDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let serie: Serie
    let textSecondary = Color.white.opacity(0.6)

    @State private var showPlaylistPicker = false
    @State private var isAddedToPlaylist = false

    @Environment(SerieViewModels.self) private var serieVM
    @Environment(PlayListViewModel.self) private var playlistVM
    @Environment(UserViewModel.self) private var userVM

    @State private var loadedPlatforms: [Platform] = []
    @State private var loadedReviews: [ReviewItem] = []
    @State private var loadedRoles: [ActorSerie] = []

    var body: some View {
        ZStack {
            Design.bgColor.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    // MARK: - 1. AFFICHE
                    if let url = serie.cover?.first?.thumbnails?.large?.url {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .containerRelativeFrame(.horizontal)
                        .frame(height: Design.coverHeight, alignment: .top)
                        .overlay(alignment: .bottom) {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    .clear, Design.bgColor,
                                ]),
                                startPoint: .center,
                                endPoint: .bottom
                            )
                        }
                        .overlay(alignment: .bottom) {
                            HStack {
                                Button {
                                    print(
                                        "Lancement du trailer pour \(serie.name)"
                                    )
                                } label: {
                                    IconButton(
                                        text: "Trailer",
                                        icon: "play.fill"
                                    )
                                }
                                Spacer()
                                Button {
                                    showPlaylistPicker.toggle()
                                } label: {
                                    if isAddedToPlaylist {
                                        IconButton(text: "Ajoutée", icon: "checkmark")
                                    } else {
                                        IconButton(text: "Ajouter", icon: "plus")
                                    }
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
                                Text("Pas d'image").foregroundStyle(
                                    textSecondary
                                )
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

                                if loadedPlatforms.isEmpty
                                    && serie.platformIDs != nil
                                {
                                    ProgressView().scaleEffect(0.7)
                                } else {
                                    ForEach(loadedPlatforms) { platform in
                                        Logo(attachments: platform.icon)
                                    }
                                }
                                
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
                        }
                        .padding(.bottom, 10)

                        // MARK: - 3. MÉTADONNÉES
                        HStack(spacing: 12) {
                            NavigationLink {
                                GenreResultsView(genre: serie.genre)
                            } label: {
                                GenreButton(genre: serie.genre.rawValue)
                            }
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.orange)
                                Text("9.9")
                                    .bold()
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(.orange.opacity(0.2))
                            .clipShape(Capsule())

                            Text(
                                "• \(String(serie.year)) • \(serie.nbSaisons) \(serie.nbSaisons <= 1 ? "Saison" : "Saisons")"
                            )
                            .foregroundStyle(textSecondary)

                        }
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .padding(.bottom)

                        // MARK: - 4. DISTRIBUTION
                        Text("Distribution")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)

                        let validActorRoles = loadedRoles.compactMap { $0 }

                        if !validActorRoles.isEmpty {
                            ScrollView(.horizontal) {
                                HStack(alignment: .top) {
                                    ForEach(validActorRoles, id: \.id) {
                                        actorRole in
                                        if let currentActor = actorRole.actor {
                                            NavigationLink {
                                                ActorProfileView(
                                                    actor: currentActor
                                                )
                                            } label: {
                                                VStack {
                                                    Spacer()
                                                    Circle()
                                                        .fill(Design.cardColor)
                                                        .frame(
                                                            width: 70,
                                                            height: 70
                                                        )
                                                        .overlay {
                                                            // ✅ CORRECTION ICI : Utilisation de AsyncImage pour le tableau d'Attachments
                                                            if let url =
                                                                currentActor
                                                                .imageName
                                                                .first??
                                                                .thumbnails?
                                                                .large?.url
                                                            {
                                                                AsyncImage(
                                                                    url: url
                                                                ) { image in
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFill()
                                                                        .clipShape(
                                                                            Circle()
                                                                        )
                                                                } placeholder: {
                                                                    ProgressView()  // Affiche une roue pendant que l'image de l'acteur se télécharge
                                                                }
                                                            }
                                                        }
                                                        .overlay {
                                                            Circle().stroke(
                                                                Design
                                                                    .accentColor,
                                                                lineWidth: 2
                                                            )
                                                        }

                                                    Text(currentActor.name)
                                                        .font(.caption)
                                                        .bold()
                                                        .foregroundStyle(.white)
                                                        .lineLimit(1)

                                                    Text(actorRole.roleName)
                                                        .font(.caption2)
                                                        .foregroundStyle(
                                                            textSecondary
                                                        )
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
                        } else if serie.actorIDs != nil {
                            ProgressView().padding(.bottom)
                        }

                        // MARK: - 5. SYNOPSIS
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

                                NavigationLink {
                                    /// (FAIRE CHAT SERIE ICI)
                                } label: {
                                    IconButton(
                                        text: "Chatter",
                                        icon: "text.bubble.fill"
                                    )
                                }
                            }

                            VStack(spacing: 12) {
                                if loadedReviews.isEmpty
                                    && serie.reviewIDs == nil
                                {
                                    Text(
                                        "Soyez le premier à laisser une critique !"
                                    )
                                    .font(.caption)
                                    .italic()
                                    .foregroundStyle(textSecondary)
                                    .padding()
                                } else {
                                    ForEach(loadedReviews) { review in
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
        .sheet(isPresented: $showPlaylistPicker) {
            if var user = userVM.currentUser {
                PlaylistPickerView(serie: serie, user: Binding(get: { user }, set: { user = $0 }))
                    .presentationDetents([.fraction(0.8), .large])
                    .presentationBackground(Design.bgColor) // Force le fond opaque
            } else {
                Text("Veuillez vous connecter pour gérer vos playlists.")
                    .presentationDetents([.medium])
            }
        }
        .onChange(of: showPlaylistPicker) { _, isShowing in
            if !isShowing {
                checkIfAdded()
            }
        }

        // MARK: - (Lazy Loading)
        .task {
            checkIfAdded()
            // 1. Plateformes
            if loadedPlatforms.isEmpty, let pIDs = serie.platformIDs {
                for id in pIDs {
                    if let p = try? await serieVM.getPlatformById(id) {
                        withAnimation {
                            loadedPlatforms.append(p)
                        }
                    }
                }
            }
            // 2. Critiques
            if loadedReviews.isEmpty, let rIDs = serie.reviewIDs {
                for id in rIDs {
                    if let r = try? await serieVM.getReviewById(id) {
                        withAnimation {
                            loadedReviews.append(r)
                        }
                    }
                }
            }
            // 3. Distribution (Rôles + Acteurs réels)
            if loadedRoles.isEmpty, let roleIDs = serie.actorIDs {
                for id in roleIDs {
                    // On va chercher le rôle
                    if var role = try? await serieVM.getRoleById(id) {
                        // On va chercher le CastMember lié à ce rôle pour avoir sa photo !
                        if let actorID = role.actorIDs?.first {
                            role.actor = try? await serieVM.getActorById(
                                actorID
                            )
                        }
                        withAnimation {
                            loadedRoles.append(role)
                        }
                    }
                }
            }
        }
    }
    
    private func checkIfAdded() {
        Task {
            if let user = userVM.currentUser {
                let added = await playlistVM.isSerieInUserPlaylists(serieName: serie.name, user: user, serieVM: serieVM)
                withAnimation {
                    self.isAddedToPlaylist = added
                }
            }
        }
    }
}

// MARK: - Preview Live Airtable
#Preview("Test Live Séries") {
    return LiveSeriesListPreview()
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(PlayListViewModel())
}
