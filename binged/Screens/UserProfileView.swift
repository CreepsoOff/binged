import SwiftUI

struct UserProfileView: View {
    let user: User
    
    let textSecondary = Color.white.opacity(0.6)
    
    var body: some View {
        ZStack {
            Design.bgColor.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // MARK: - 1. En-tête (Photo & Infos de base)
                    VStack(spacing: 12) {
                        if let imageURL = user.picture?.first?.thumbnails?.large?.url {
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Design.accentColor, lineWidth: 3))
                            .shadow(color: Design.accentColor.opacity(0.3), radius: 10)
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .foregroundStyle(Design.cardColor)
                        }
                        
                        VStack(spacing: 4) {
                            Text("\(user.firstName ?? "") \(user.lastName ?? "")")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.white)
                            
                            Text("@\(user.userName) • \(user.age ?? 0) ans")
                                .font(.subheadline)
                                .foregroundStyle(Design.accentColor)
                        }
                        
                        if let bio = user.userBio, !bio.isEmpty {
                            Text(bio)
                                .font(.callout)
                                .italic()
                                .foregroundStyle(textSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                        }
                    }
                    .padding(.top, 20)
                    
                    // MARK: - 2. Genres Favoris
                    if let genres = user.favoriteGenreStrings, !genres.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(genres, id: \.self) { genre in
                                    Text(genre)
                                        .font(.caption)
                                        .bold()
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Design.innerCardColor)
                                        .clipShape(Capsule())
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Divider().background(Design.cardColor).padding(.horizontal)
                    
                    // MARK: - 3. Séries Favorites
                    let validSeries = user.favoriteSeries.compactMap { $0 }
                    VStack(alignment: .leading, spacing: 0) {
                        SectionView(title: "Séries Favorites", isEmpty: validSeries.isEmpty)
                        
                        if !validSeries.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(validSeries) { serie in
                                        NavigationLink {
                                            SeriesDetailView(serie: serie)
                                        } label: {
                                            VStack(alignment: .leading) {
                                                Rectangle()
                                                    .fill(Design.cardColor)
                                                    .frame(width: 110, height: 160)
                                                    .overlay(
                                                        Group {
                                                            if let cover = serie.cover {
                                                                Image(cover) // Adapter si URL plus tard
                                                                    .resizable()
                                                                    .scaledToFill()
                                                            } else {
                                                                Text("No Image").foregroundStyle(textSecondary).font(.caption)
                                                            }
                                                        }
                                                    )
                                                    .clipShape(.rect(cornerRadius: 12))
                                                
                                                Text(serie.name)
                                                    .font(.caption)
                                                    .bold()
                                                    .foregroundStyle(.white)
                                                    .lineLimit(1)
                                                    .frame(width: 110, alignment: .leading)
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 12)
                            }
                        }
                    }
                    
                    // MARK: - 4. Acteurs Favoris
                    let validActors = user.favoriteActors.compactMap { $0 }
                    VStack(alignment: .leading, spacing: 0) {
                        SectionView(title: "Acteurs Favoris", isEmpty: validActors.isEmpty)
                        
                        if !validActors.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(validActors) { actor in
                                        NavigationLink {
                                            ActorProfileView(actor: actor)
                                        } label: {
                                            VStack {
                                                Circle()
                                                    .fill(Design.cardColor)
                                                    .frame(width: 80, height: 80)
                                                    .overlay(
                                                        Group {
                                                            if let img = actor.imageName {
                                                                Image(img)
                                                                    .resizable()
                                                                    .scaledToFill()
                                                                    .clipShape(Circle())
                                                            }
                                                        }
                                                    )
                                                
                                                Text(actor.name)
                                                    .font(.caption)
                                                    .foregroundStyle(textSecondary)
                                                    .lineLimit(1)
                                                    .frame(width: 80)
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 12)
                            }
                        }
                    }
                    
                    // MARK: - 5. Playlists
                    let validPlaylists = user.playlists.compactMap { $0 }
                    VStack(alignment: .leading, spacing: 0) {
                        // 👇 APPEL DU HEADER
                        SectionView(title: "Mes Playlists", isEmpty: validPlaylists.isEmpty)
                        
                        // 👇 LE CONTENU EN DESSOUS
                        if !validPlaylists.isEmpty {
                            VStack(spacing: 12) {
                                ForEach(validPlaylists) { playlist in
                                    HStack {
                                        Image(systemName: "play.square.stack.fill")
                                            .font(.title)
                                            .foregroundStyle(Design.accentColor)
                                        
                                        VStack(alignment: .leading) {
                                            Text(playlist.name)
                                                .font(.headline)
                                                .foregroundStyle(.white)
                                            Text("\(playlist.serieIDs?.count ?? 0) séries")
                                                .font(.caption)
                                                .foregroundStyle(textSecondary)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(textSecondary)
                                    }
                                    .padding()
                                    .background(Design.cardColor)
                                    .clipShape(.rect(cornerRadius: 16))
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top, 12)
                        }
                    }
                    
                    Spacer(minLength: 40)
                }
            }
        }
        .navigationTitle("Profil")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { print("Ouvrir les réglages") }) {
                    Image(systemName: "gearshape.fill")
                        .accessibilityLabel("Réglages")
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NavigationLink {
            UserProfileView(user: MockData.magalie)
        } label: {
            Text("User")
                .padding(64)
                .background(Design.accentColor)
                .bold()
                .foregroundStyle(.black)
                .clipShape(.rect(cornerRadius: 24))
        }
    }
    .environment(SerieViewModels())

}
