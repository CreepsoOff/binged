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
                    if let imgName = actor.imageName, !imgName.isEmpty {
                        Image(imgName)
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
#Preview("Test Live Airtable") {
    
    struct LiveAirtablePreview: View {
        @State private var viewModel = SerieViewModels()
        
        /// Dictionnaire des acteurs reliés à CastMember
        var allActors: [CastMember] {
            var uniqueActors: [String: CastMember] = [:]
            
            for serie in viewModel.series {
                let roles = serie.actors.compactMap { $0 }
                for role in roles {
                    if let actor = role.actor {
                        uniqueActors[actor.name] = actor
                    }
                }
            }
            return Array(uniqueActors.values)
        }
        
        var body: some View {
            NavigationStack {
                Group {
                    if viewModel.isLoading {
                        VStack(spacing: 16) {
                            ProgressView()
                            Text("Téléchargement depuis Airtable...")
                                .foregroundStyle(.secondary)
                        }
                    } else if allActors.isEmpty {
                        Text("Aucun acteur trouvé.")
                            .foregroundStyle(.secondary)
                    } else {
                        List(allActors, id: \.id) { actor in
                            NavigationLink {
                                ActorProfileView(actor: actor)
                            } label: {
                                HStack {
                                    if let img = actor.imageName, !img.isEmpty {
                                        Image(img)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                    } else {
                                        Circle()
                                            .fill(Design.cardColor)
                                            .frame(width: 40, height: 40)
                                    }
                                    
                                    Text(actor.name)
                                        .foregroundStyle(.primary)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Acteurs (Airtable)")
            }
            .environment(viewModel)
            .task {
                do {
                    try await viewModel.fetchSeries()
                } catch {
                    print("Erreur Airtable dans la Preview : \(error)")
                }
            }
        }
    }
    
    return LiveAirtablePreview()
}
