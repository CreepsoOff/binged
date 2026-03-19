//
//  AutherProfil.swift
//  binged
//
//  Created by Apprenant 105 on 12/03/2026.
//

import SwiftUI

struct AutherProfil: View {
    
    @State var user: User
    @State private var isFollow = false
    @State var vmuser = UserViewModel()
    
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
                                    .scaledToFill()
                                    .padding(.horizontal)
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
                                .frame(width: UIScreen.main.bounds.width / 2, height: 100)
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                                .lineLimit(5)
                            Button(action: {
                                isFollow.toggle()
                            }) {
                                Image(systemName: isFollow ? "person.fill.xmark" : "person.fill.checkmark")
                                    .padding(8)
                                    .background(.orange)
                                    .cornerRadius(20)
                                    .foregroundColor(.white)
                            }
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
                                    actorBar(actor: actor)
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
                    .padding(.horizontal, 8)
                }
                .padding(.horizontal, 8)
            }
//        }.task {
//            do {
//                self.user = try await vmuser.getUserById("rec279AxVMVJ5GrPQ")
//            } catch {
//                print(error)
//            }
        }
    }
}

#Preview {
    AutherProfil(user: MockData.colette)
}
