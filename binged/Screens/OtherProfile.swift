//
//  AuthorProfile.swift
//  binged
//
//  Created by Apprenant 105 on 12/03/2026.
//

import SwiftUI

struct OtherProfile: View {
    
    @Binding var user: User
    @State private var isFollow = false
    @Environment(SerieViewModels.self) private var vmSerie
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                VStack {
                    Text(user.firstName!)
                        .foregroundStyle(.white)
                        .font(.system(size: 32))
                    HStack {
                        if let url = user.picture?.first?.thumbnails?.large?.url {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 200, height: 100)

                        }else {
                            Image(systemName : "person.crop.circle")
                                .font(.system(size: 100))
                        }
                        Spacer()
                        VStack{
                            Text(user.userBio!)
                                .foregroundStyle(.white)
                                .font(.system(size: 16))
                                .lineLimit(5)
                            
                            Button(action: {
                                isFollow.toggle()
                            }) {
                                withAnimation {
                                    IconButton(text: isFollow ? "Se désabonner" : "S'abonner", icon: isFollow ? "person.fill.checkmark" : "person.fill.xmark")

                                }
                            }
                            
                        }
                        
                    }
                    .frame(width: .infinity, height: 220)
                    VStack(alignment: .leading) {
                        Text("Ces Favoris")
                            .foregroundStyle(.white)
                            .font(.system(size: 32))
                            .padding(.horizontal, 10)
                    }
                    ScrollView {
                        Text("Genres")
                            .foregroundStyle(.white)
                            .font(.system(size: 24))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(user.favoriteGenres, id:\.rawValue) { genre in
                                    NavigationLink {
                                        GenreResultsView(genre: genre)
                                    } label: {
                                        GenreButton(genre: genre.rawValue)
                                    }
                                }
                            }
                        }
                        Text("Acteurs")
                            .foregroundStyle(.white)
                            .font(.system(size: 24))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10)
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(user.favoriteActorsSafe){ actor in
                                    NavigationLink {
                                        ActorProfileView(actor: actor)
                                    } label: {
                                        ActorBar(actor: actor)
                                    }
                                }
                            }
                        }
                        
                        HStack {
                            Text("Série")
                                .foregroundStyle(.white)
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 10)
                            NavigationLink {
                                PlaylistsView(user: $user)
                            } label: {
                                IconButton(text: "Playlist", icon: "book.pages.fill")
                            }
                        }
                        TabView {
                            ForEach(user.favoriteSeriesSafe) { serie in
                                NavigationLink {
                                    SeriesDetailView(serie: serie)
                                } label: {
                                    if let url = serie.cover?.first?.thumbnails?.large?.url {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(2/3, contentMode: .fit)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(height: 450)
                                        .clipShape(.rect(cornerRadius: 15))
                                        .padding(.horizontal)
                                    } else {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.3))
                                            .aspectRatio(2/3, contentMode: .fit)
                                            .frame(height: 450)
                                            .clipShape(.rect(cornerRadius: 15))
                                            .padding(.horizontal)
                                    }
                                }
                            }
                        }
                        .frame(height: 480)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    }
                }
            }
        }
        .task {
            if let seriesIDs = user.favoriteSerieIDs {
                for id in seriesIDs {
                    if let s = try? await vmSerie.getSerieById(id) {
                        if !user.favoriteSeries.contains(where: { $0?.name == s.name }) {
                            user.favoriteSeries.append(s)
                        }
                    }
                }
            }
            
            if let actorIDs = user.favoriteActorIDs {
                for id in actorIDs {
                    if let a = try? await vmSerie.getActorById(id) {
                        if !user.favoriteActors.contains(where: { $0?.name == a.name }) {
                            user.favoriteActors.append(a)
                        }
                    }
                }
            }
        }
    }
}


#Preview("Airtable - Profil Briand") {
    return OtherProfilePreview()
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(PlayListViewModel())
}
