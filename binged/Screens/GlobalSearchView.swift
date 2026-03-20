import SwiftUI

struct GlobalSearchView: View {
    @Environment(SerieViewModels.self) private var serieVM
    @Environment(UserViewModel.self) private var userVM
    @Environment(ActorViewModel.self) private var actorVM
    
    @State private var searchText = ""
    @State private var isInitialLoading = true
    
    // MARK: - Filtered Results
    var filteredSeries: [Serie] {
        if searchText.isEmpty { return serieVM.series }
        return serieVM.series.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var filteredGenres: [GenreType] {
        if searchText.isEmpty { return GenreType.allCases }
        return GenreType.allCases.filter { $0.rawValue.localizedCaseInsensitiveContains(searchText) }
    }
    
    var filteredActors: [CastMember] {
        if searchText.isEmpty { return serieVM.allActors }
        return serieVM.allActors.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var filteredUsers: [User] {
        if searchText.isEmpty { return userVM.users }
        return userVM.users.filter { $0.userName.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Design.bgColor.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    SearchBar(text: $searchText)
                        .padding(.vertical, 10)
                    
                    if isInitialLoading {
                        Spacer()
                        ProgressView("Initialisation...")
                            .tint(.orange)
                            .foregroundStyle(.white)
                        Spacer()
                    } else {
                        ScrollView {
                            VStack(spacing: 24) {
                                
                                // MARK: - Series Section
                                VStack(alignment: .leading) {
                                    SectionView(title: "Séries", isEmpty: filteredSeries.isEmpty)
                                    
                                    if !filteredSeries.isEmpty {
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 16) {
                                                ForEach(filteredSeries) { serie in
                                                    NavigationLink {
                                                        SeriesDetailView(serie: serie)
                                                    } label: {
                                                        VStack(alignment: .leading) {
                                                            if let url = serie.cover?.first?.thumbnails?.large?.url {
                                                                AsyncImage(url: url) { image in
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFill()
                                                                } placeholder: {
                                                                    ProgressView()
                                                                }
                                                                .frame(width: 140, height: 200)
                                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                            } else {
                                                                RoundedRectangle(cornerRadius: 12)
                                                                    .fill(Design.cardColor)
                                                                    .frame(width: 140, height: 200)
                                                                    .overlay(Image(systemName: "tv").foregroundStyle(.gray))
                                                            }
                                                            
                                                            Text(serie.name)
                                                                .font(.caption)
                                                                .bold()
                                                                .foregroundStyle(.white)
                                                                .lineLimit(1)
                                                                .frame(width: 140, alignment: .leading)
                                                        }
                                                    }
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                                
                                // MARK: - Genres Section
                                VStack(alignment: .leading) {
                                    SectionView(title: "Genres", isEmpty: filteredGenres.isEmpty)
                                    
                                    if !filteredGenres.isEmpty {
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 12) {
                                                ForEach(filteredGenres, id: \.self) { genre in
                                                    NavigationLink {
                                                        GenreResultsView(genre: genre)
                                                    } label: {
                                                        GenreButton(genre: genre.rawValue)
                                                    }
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                                
                                // MARK: - Actors Section
                                VStack(alignment: .leading) {
                                    SectionView(title: "Acteurs", isEmpty: filteredActors.isEmpty)
                                    
                                    if !filteredActors.isEmpty {
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 16) {
                                                ForEach(filteredActors, id: \.id) { actor in
                                                    NavigationLink {
                                                        ActorProfileView(actor: actor)
                                                    } label: {
                                                        ActorBar(actor: actor)
                                                    }
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                                
                                // MARK: - Users Section
                                VStack(alignment: .leading) {
                                    SectionView(title: "Utilisateurs", isEmpty: filteredUsers.isEmpty)
                                    
                                    if !filteredUsers.isEmpty {
                                        VStack(spacing: 12) {
                                            ForEach(filteredUsers, id: \.id) { user in
                                                NavigationLink {
                                                    // On passe un Binding constant car OtherProfile attend un Binding
                                                    OtherProfile(user: .constant(user))
                                                } label: {
                                                    HStack {
                                                        if let url = user.picture?.first?.thumbnails?.large?.url {
                                                            AsyncImage(url: url) { image in
                                                                image
                                                                    .resizable()
                                                                    .scaledToFill()
                                                            } placeholder: {
                                                                ProgressView()
                                                            }
                                                            .frame(width: 50, height: 50)
                                                            .clipShape(Circle())
                                                        } else {
                                                            Image(systemName: "person.crop.circle.fill")
                                                                .resizable()
                                                                .frame(width: 50, height: 50)
                                                                .foregroundStyle(.gray)
                                                        }
                                                        
                                                        VStack(alignment: .leading) {
                                                            Text(user.userName)
                                                                .font(.headline)
                                                                .foregroundStyle(.white)
                                                            if let firstName = user.firstName, let lastName = user.lastName {
                                                                Text("\(firstName) \(lastName)")
                                                                    .font(.caption)
                                                                    .foregroundStyle(.gray)
                                                            }
                                                        }
                                                        
                                                        Spacer()
                                                        
                                                        Image(systemName: "chevron.right")
                                                            .foregroundStyle(.gray)
                                                    }
                                                    .padding()
                                                    .background(Design.cardColor)
                                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                                }
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                
                            }
                            .padding(.bottom, 30)
                        }
                    }
                }
            }
            .navigationTitle("Recherche Globale")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Design.bgColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .task {
            do {
                // On charge tout au début
                async let seriesFetch: () = serieVM.fetchLightSeries()
                async let actorsFetch: () = serieVM.fetchAllActors()
                async let usersFetch: () = userVM.fetchUsers()
                
                _ = try await [seriesFetch, actorsFetch, usersFetch]
                
                isInitialLoading = false
            } catch {
                print("Erreur lors du chargement initial : \(error)")
                isInitialLoading = false
            }
        }
    }
}

#Preview {
    GlobalSearchView()
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(ActorViewModel())
}
