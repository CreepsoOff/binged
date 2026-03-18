import SwiftUI

struct ActorProfileView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Environment(SerieViewModels.self) private var viewModel
    
    let actor: CastMember
    let textSecondary = Color.white.opacity(0.6)
    
    var actorSeries: [Serie] {
        viewModel.series.filter { serie in
            /// compactMap s'assure de ne pas inclure de "nil"
            let validActorRoles = serie.actors.compactMap { $0 }
            return validActorRoles.contains { $0.actor?.name == actor.name }
        }
    }

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

                        // MARK: - Filmographie
                        Text("Apparaît dans")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)

                        if actorSeries.isEmpty {
                            Text("Aucune série répertoriée pour le moment.")
                                .foregroundStyle(textSecondary)
                                .padding(.bottom, 40)
                        } else {
                            ScrollView(.horizontal) {
                                HStack(alignment: .top, spacing: 16) {
                                    ForEach(actorSeries, id: \.id) { serie in
                                        
                                        NavigationLink
                                        {
                                            SeriesDetailView(serie: serie)
                                        } label: {
                                            VStack(alignment: .leading) {
                                                if let cover = serie.cover {
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

                                                Text(serie.name)
                                                    .font(.caption)
                                                    .bold()
                                                    .foregroundStyle(.white)
                                                    .lineLimit(1)
                                                
                                                if let role = serie.actors.compactMap({ $0 }).first(where: { $0.actor?.name == actor.name })?.roleName {
                                                    Text(role)
                                                        .font(.caption2)
                                                        .foregroundStyle(textSecondary)
                                                        .lineLimit(1)
                                                }
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
            .scrollIndicators(.hidden)
            .ignoresSafeArea(edges: .top)
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
