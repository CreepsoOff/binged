//
//  AuthorProfile.swift
//  binged
//
//  Created by Apprenant 105 on 12/03/2026.
//

import SwiftUI

struct AuthorProfile: View {
    
    var user: User
    
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
                            
                            BasicButton(text: "Suivre")
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
                                    GenreButton(genre: genre.rawValue)
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
                                    ActorBar(actor: actor)
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
                                PlaylistsView(user: user)
                            } label: {
                                IconButton(text: "Playlist", icon: "book.pages.fill")
                            }
                        }
                        TabView {
                            ForEach(user.favoriteSeriesSafe) { serie in
                                Image(serie.cover!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 250)
                                    .clipped()
                                    .clipShape(.rect(cornerRadius: 10))
                                    .padding(.horizontal)
                            }
                        }
                        .frame(height: 250)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    }
                }
            }
        }
    }
}


#Preview("Airtable - Profil Briand") {
    
    struct AuthorProfilePreview: View {
        @State private var userVM = UserViewModel()
        @State private var liveUser: User?
        
        var body: some View {
            ZStack {
                Color("background").ignoresSafeArea()
                
                if let user = liveUser {
                    AuthorProfile(user: user)
                        .environment(userVM)
                } else {
                    ProgressView("Chargement du profil...")
                        .tint(.white)
                        .foregroundStyle(.white)
                }
            }
            .task {
                do {
                    let briandID = "rec15VTfdnBrUWmBb"
                    self.liveUser = try await userVM.getUserById(briandID)
                } catch {
                    print("Erreur de chargement dans la Preview : \(error)")
                }
            }
        }
    }
    
    return AuthorProfilePreview()
}
