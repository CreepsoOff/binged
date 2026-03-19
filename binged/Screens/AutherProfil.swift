//
//  AutherProfil.swift
//  binged
//
//  Created by apprenant85 on 18/03/2026.
//

import SwiftUI

struct AutherProfil: View {

    @Binding var user: User
    @State private var isFollow = false
    @Environment(UserViewModel.self) private var vmuser
    @Environment(SerieViewModels.self) private var vmSerie

    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                VStack {
                    Text(user.firstName!)
                        .foregroundColor(.white)
                        .font(.system(size: 32))
                    HStack {
                        if let url = user.picture?.first?.thumbnails?.large?.url
                        {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .padding(.horizontal)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 200, height: 100)
                        } else {
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: 100))
                        }
                        Spacer()
                        VStack {
                            Text(user.userBio!)
                                .containerRelativeFrame(.horizontal) {
                                    length,
                                    _ in
                                    length / 2
                                }
                                .frame(height: 100)
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                                .lineLimit(5)
                            Button(action: {
                                isFollow.toggle()
                            }) {
                                Image(
                                    systemName: isFollow
                                        ? "person.fill.checkmark"
                                        : "person.fill.xmark"
                                )
                                Text(isFollow ? "Se désabonner" : "S'abonner")
                            }
                            .padding(8)
                            .background(.orange)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                        }
                    }
                    .frame(width: .infinity, height: 220)

                    VStack(alignment: .leading) {
                        Text("Ces Favoris")
                            .foregroundColor(.white)
                            .font(.system(size: 32))
                            .padding(.horizontal, 10)
                    }
                    ScrollView {
                        Text("Genres")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(user.favoriteGenres, id: \.self) { genre in
                                    NavigationLink {
                                        GenreResultsView(genre: genre)
                                    } label: {
                                        GenreButton(genre: genre.rawValue)
                                    }
                                }
                            }.padding(.horizontal, 8)
                        }
                        Text("Acteurs")
                            .foregroundColor(.white)
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
                            .padding(.horizontal, 8)
                        }

                        HStack {
                            Text("Série")
                                .foregroundColor(.white)
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 10)
                            NavigationLink {
                                PlaylistsView(user: $user)
                            } label: {
                                IconButton(
                                    text: "Playlist",
                                    icon: "book.pages.fill"
                                )
                            }
                        }
                        TabView {
                            ForEach(user.favoriteSeriesSafe) { serie in
                                NavigationLink {
                                    SeriesDetailView(serie: serie)
                                } label: {
                                    if let url = serie.cover?.first?.thumbnails?
                                        .large?.url
                                    {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(height: 250)
                                        .clipped()
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                    } else {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(height: 250)
                                            .cornerRadius(10)
                                            .padding(.horizontal)
                                    }
                                }
                            }
                        }
                        .frame(height: 250)
                        .tabViewStyle(
                            PageTabViewStyle(indexDisplayMode: .automatic)
                        )
                    }
                    .padding(.horizontal, 8)
                }
                .padding(.horizontal, 8)
            }
        }.task {
            // Cascade fetch for Series
            if let seriesIDs = user.favoriteSerieIDs {
                for id in seriesIDs {
                    if let s = try? await vmSerie.getSerieById(id) {
                        if !user.favoriteSeries.contains(where: {
                            $0?.name == s.name
                        }) {
                            user.favoriteSeries.append(s)
                        }
                    }
                }
            }

            if let actorIDs = user.favoriteActorIDs {
                for id in actorIDs {
                    if let a = try? await vmSerie.getActorById(id) {
                        if !user.favoriteActors.contains(where: {
                            $0?.name == a.name
                        }) {
                            user.favoriteActors.append(a)
                        }
                    }
                }
            }
        }
    }
}

#Preview() {
    AutherProfil(user: .constant(MockData.magalie))
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(PlayListViewModel())
}
