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
                    
                    // MARK: - 1. HEADER (Photo & Infos)
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
                            .overlay {
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, Design.bgColor]),
                                    startPoint: .center,
                                    endPoint: .bottom
                                )
                            }
                        }
                        
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
                            } else {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top, spacing: 16) {
                                        ForEach(loadedData, id: \.role.id) { data in
                                            NavigationLink {
                                                SeriesDetailView(serie: data.serie)
                                            } label: {
                                                VStack(alignment: .leading) {
                                                    // Cover Série
                                                    if let url = data.serie.cover?.first?.thumbnails?.large?.url {
                                                        AsyncImage(url: url) { image in
                                                            image
                                                                .resizable()
                                                                .scaledToFill()
                                                        } placeholder: {
                                                            ProgressView()
                                                        }
                                                        .frame(width: 120, height: 180)
                                                        .clipped()
                                                        .cornerRadius(12)
                                                    }
                                                    
                                                    Text(data.serie.name)
                                                        .font(.caption)
                                                        .bold()
                                                        .foregroundStyle(.white)
                                                        .lineLimit(1)
                                                    
                                                    Text(data.role.roleName)
                                                        .font(.system(size: 10))
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
        }
        .toolbar(.hidden, for: .tabBar)
        .task {
            // MARK: - LOGIQUE DE CASCADE (Fetch Roles -> Fetch Series)
            // On ne le fait que si on n'a pas déjà chargé les données
            if loadedData.isEmpty {
                if let roleIDs = actor.actorSerieIDs {
                    do {
                        for roleID in roleIDs {
                            // 1. Fetch du rôle complet
                            let role = try await viewModel.getRoleById(roleID)
                            
                            // 2. Récupération de l'ID de la série liée
                            guard let serieID = role.serieIDs?.first else { continue }
                            
                            // 3. Fetch de la série complète
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
