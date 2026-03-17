//
//  AutherProfil.swift
//  binged
//
//  Created by Apprenant 105 on 12/03/2026.
//

import SwiftUI

struct AutherProfil: View {
    
    var user: User
    
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
                        if let url = user.picture?.first?.thumbnails?.large?.url {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .clipShape(Circle())
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)

                        }else {
                            Image(systemName : "person.crop.circle")
                                .font(.system(size: 100))
                        }
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 200, height: 220)
//                            .padding()
                        VStack{
                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s")
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                                .lineLimit(8)
                            basicButton(text: "Suivre")
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
                                genreButton(genre: "Action")
                                genreButton(genre: "Policier")
                                genreButton(genre: "Romance")
                            }
                        }
                        Text("Acteurs")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10)
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(user.favoriteActorsSafe){ actor in
                                    actorBar(actor: actor)
                                }
                            }
                        }
                        
                        HStack {
                            Text("Série")
                                .foregroundColor(.white)
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 10)
                            NavigationLink {
                                PlaylistsView(user: MockData.colette)
                            } label: {
                                iconButton(text: "Playlist", icon: "book.pages.fill")
                            }
                        }
                        TabView {
                            ForEach(user.favoriteSeriesSafe) { serie in
                                Image(serie.cover!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 250)
                                    .clipped()
                                    .cornerRadius(10)
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

#Preview {
    AutherProfil(user: MockData.colette)
}
