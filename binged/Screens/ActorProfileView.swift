import SwiftUI

struct ActorProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(SerieViewModels.self) private var viewModel
    
    let actor: CastMember
    let textSecondary = Color.white.opacity(0.6)
    
    // État local pour stocker les résultats du fetch en cascade
    @State private var loadedData: [(serie: Serie, role: ActorSerie)] = []
    @State private var isLoadingData = true
    
    var body: some View {
        ZStack {
            Design.bgColor.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // MARK: - 1. EN-TÊTE (PHOTO & NOM)
                    ZStack(alignment: .bottomLeading) {
                        if let url = actor.imageName.first??.thumbnails?.large?.url {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 400)
                            .clipped()
                        } else {
                            Rectangle()
                                .fill(Design.cardColor)
                                .frame(height: 400)
                                .overlay {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 80))
                                        .foregroundStyle(.white.opacity(0.2))
                                }
                        }
                        
                        // Dégradé pour la lisibilité du nom
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, Design.bgColor]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(actor.name)
                                .font(.system(size: 40, weight: .heavy))
                                .foregroundStyle(.white)
                            
                            HStack {
                                Text(actor.cityOfBirth ?? "Lieu inconnu")
                                Text("•")
                                Text("\(actor.age) ans")
                            }
                            .font(.subheadline)
                            .foregroundStyle(textSecondary)
                        }
                        .padding()
                    }
                    
                    VStack(alignment: .leading, spacing: 25) {
                        
                        // MARK: - 2. BIO
                        if let bio = actor.bio, !bio.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Biographie")
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(.white)
                                
                                Text(bio)
                                    .font(.body)
                                    .foregroundStyle(textSecondary)
                                    .lineLimit(nil)
                            }
                            .padding(.horizontal)
                        }
                        
                        // MARK: - 3. FILMOGRAPHIE (LA CASCADE !)
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Filmographie")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            
                            if isLoadingData {
                                HStack {
                                    Spacer()
                                    ProgressView("Chargement des rôles...")
                                        .tint(.white)
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                                .padding()
                            } else if loadedData.isEmpty {
                                Text("Aucune série trouvée pour cet acteur.")
                                    .italic()
                                    .foregroundStyle(.gray)
                                    .padding(.horizontal)
                            } else {
                                ScrollView(.horizontal) {
                                    HStack(alignment: .top, spacing: 16) {
                                        ForEach(loadedData, id: \.serie.id) { item in
                                            
                                            NavigationLink {
                                                SeriesDetailView(serie: item.serie)
                                            } label: {
                                                VStack(alignment: .leading) {
                                                    if let url = item.serie.cover?.first?.thumbnails?.large?.url {
                                                        AsyncImage(url: url) { image in
                                                            image
                                                                .resizable()
                                                                .scaledToFill()
                                                        } placeholder: {
                                                            ProgressView()
                                                        }
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
                                    .padding(.horizontal)
                                }
                                .scrollIndicators(.hidden)
                            }
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 50)
                }
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea(edges: .top)
            
//            // Bouton Retour
//            VStack {
//                HStack {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "chevron.left")
//                            .font(.title3.bold())
//                            .foregroundStyle(.white)
//                            .padding(12)
//                            .background(.ultraThinMaterial)
//                            .clipShape(Circle())
//                    }
//                    Spacer()
//                }
//                .padding()
//                Spacer()
//            }
        }
//        .navigationBarHidden(true)
        
        // MARK: - LOGIQUE DE FETCH EN CASCADE
        .task {
            // Si on a déjà chargé les données, on ne recommence pas
            guard loadedData.isEmpty else { return }
            
            isLoadingData = true
            
            // 1. On récupère la liste des IDs de rôles (ActorSerie)
            if let roleIDs = actor.actorSerieIDs {
                for roleID in roleIDs {
                    do {
                        // 2. On fetch chaque objet ActorSerie (le Rôle)
                        let role = try await viewModel.getRoleById(roleID)
                        
                        // 3. On fetch la Série associée à ce rôle
                        if let serieID = role.serieIDs?.first {
                            let serie = try await viewModel.getSerieById(serieID)
                            
                            // 4. On ajoute le couple (Série, Rôle) à notre liste locale
                            withAnimation {
                                loadedData.append((serie: serie, role: role))
                            }
                        }
                    } catch {
                        print("Erreur cascade acteur: \(error)")
                    }
                }
            }
            
            isLoadingData = false
        }
    }
}

// MARK: - Preview Live Airtable
#Preview("Test Live Actor") {
    return SingleActorPreview()
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(PlayListViewModel())
}
