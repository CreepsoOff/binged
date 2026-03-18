import SwiftUI

struct ActorProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(SerieViewModels.self) private var viewModel
    
    let actor: CastMember
    let textSecondary = Color.white.opacity(0.6)
    
    // 1. AJOUT : On stocke la série ET le rôle ensemble !
    @State private var loadedData: [(role: ActorSerie, serie: Serie)] = []
    @State private var isLoading = true

    var body: some View {
        ZStack {
            Design.bgColor.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    // MARK: - Image de couverture
                    if let url = actor.imageName.first??.thumbnails?.large?.url {
                        AsyncImage(url: url) { image in
                            image
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
                                .clipped()

                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: Design.coverHeight, alignment: .top)
                    } else {
                        Rectangle()
                            .fill(Design.cardColor)
                            .frame(height: Design.coverHeight)
                            .overlay {
                                Text("Pas d'image").foregroundStyle(textSecondary)
                            }
                    }

                    VStack(alignment: .leading) {

                        // MARK: - Informations personnelles
                        Text(actor.name)
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.white)

                        HStack {
                            Text("\(actor.age) ans")
                                .bold()
                                .foregroundStyle(.white)
                            
                            Text("• Né(e) à \(actor.cityOfBirth ?? "Inconnu") • \(actor.dateOfBirth.formatDDMMYYYY())")
                                .foregroundStyle(textSecondary)
                        }
                        .font(.subheadline)
                        .padding(.bottom)

                        // MARK: - Biographie
                        if let bio = actor.bio, !bio.isEmpty {
                            Text("Biographie")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(.white)

                            Text(bio)
                                .foregroundStyle(textSecondary)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Design.cardColor)
                                .clipShape(.rect(cornerRadius: 16))
                                .padding(.bottom)
                        }

                        // MARK: - Filmographie (LAZY LOADING)
                        Text("Apparaît dans")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)

                        if isLoading {
                            ProgressView()
                                .tint(.white)
                                .padding(.top, 20)
                                .padding(.bottom, 40)
                        } else if loadedData.isEmpty {
                            Text("Aucune série répertoriée pour le moment.")
                                .foregroundStyle(textSecondary)
                                .padding(.top, 10)
                                .padding(.bottom, 40)
                        } else {
                            ScrollView(.horizontal) {
                                HStack(alignment: .top, spacing: 16) {
                                    // On boucle sur notre Tuple
                                    ForEach(loadedData, id: \.serie.id) { item in
                                        
                                        NavigationLink {
                                            SeriesDetailView(serie: item.serie)
                                        } label: {
                                            VStack(alignment: .leading) {
                                                if let cover = item.serie.cover {
                                                    Image(cover)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 120, height: 180)
                                                        .clipShape(.rect(cornerRadius: 12))
                                                } else {
                                                    Rectangle()
                                                        .fill(Design.cardColor)
                                                        .frame(width: 120, height: 180)
                                                        .clipShape(.rect(cornerRadius: 12))
                                                }

                                                Text(item.serie.name)
                                                    .font(.caption)
                                                    .bold()
                                                    .foregroundStyle(.white)
                                                    .lineLimit(1)
                                                
                                                // LE RETOUR DU NOM DU RÔLE ! 🎉
                                                Text(item.role.roleName)
                                                    .font(.caption2)
                                                    .foregroundStyle(textSecondary)
                                                    .lineLimit(1)
                                            }
                                            .frame(width: 120)
                                        }
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                            .padding(.bottom, 40)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea(edges: .top)
        
        // MARK: - 2. MOTEUR DE TÉLÉCHARGEMENT (Cascade)
        .task {
            // 1. On parcourt les IDs de "ActorSerie" de l'acteur
            if let roleIDs = actor.actorSerieIDs {
                for roleID in roleIDs {
                    // 2. On télécharge le rôle précis
                    if let role = try? await viewModel.getRoleById(roleID) {
                        
                        // 3. On extrait l'ID de la série depuis le rôle, et on la télécharge
                        if let serieID = role.serieIDs?.first,
                           let serie = try? await viewModel.getSerieById(serieID) {
                            
                            // 4. On ajoute les deux ensemble pour l'affichage (si la série n'y est pas déjà)
                            if !loadedData.contains(where: { $0.serie.name == serie.name }) {
                                loadedData.append((role: role, serie: serie))
                            }
                        }
                    }
                }
            }
            isLoading = false
        }
    }
}

// MARK: - Preview
// MARK: - Preview Lazy Loading
#Preview("Test Live Airtable - Un Acteur") {
    
    struct SingleActorPreview: View {
        // 1. Initialisation du ViewModel
        @State private var viewModel = SerieViewModels()
        // 2. La variable pour stocker notre acteur cible
        @State private var liveActor: CastMember?
        
        var body: some View {
            NavigationStack {
                ZStack {
                    Design.bgColor.ignoresSafeArea()
                    
                    // 3. Affichage conditionnel
                    if let actor = liveActor {
                        // On injecte l'environnement pour que la vue puisse faire ses propres fetchs (les séries de l'acteur)
                        ActorProfileView(actor: actor)
                            .environment(viewModel)
                    } else {
                        VStack(spacing: 16) {
                            ProgressView()
                                .tint(.white)
                                .scaleEffect(1.5)
                            Text("Téléchargement de l'acteur...")
                                .foregroundStyle(.white.opacity(0.6))
                        }
                    }
                }
            }
            // 4. Le fameux .task pour le FetchByID !
            .task {
                do {
                    // Remplace par n'importe quel ID "rec..." d'acteur de ta base Airtable (ici Aaron Paul)
                    let targetID = "recNqCTo2Rdq9gzAT"
                    self.liveActor = try await viewModel.getActorById(targetID)
                } catch {
                    print("Erreur de chargement dans la Preview : \(error)")
                }
            }
        }
    }
    
    return SingleActorPreview()
}
