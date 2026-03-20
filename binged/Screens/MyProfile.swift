//
//  myProffil.swift
//  binged
//
//  Created by Apprenant 92 on 06/03/2026.
//

import SwiftUI

struct MyProfile: View {
    @Environment(UserViewModel.self) private var vmUser
    @Environment(SerieViewModels.self) private var vmSerie
    @State var userConnected: User
    
    // États pour la modification du texte
    @State private var bioText: String = "Acteur et producteur américain célèbre pour Fight Club, Seven et Once Upon a Time in Hollywood. Il a remporté plusieurs Oscars."
    @State private var isEditing: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 20) {
                    
                    Text("Bienvenue \(userConnected.firstName!)")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 10)
                    
                    // Section Photo à gauche & Bio à droite
                    HStack(alignment: .top, spacing: 20) {
                        // Photo
                        if let url = userConnected.picture?.first?.thumbnails?.large?.url {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 110, height: 110)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Design.accentColor.opacity(0.5), lineWidth: 2))
                            } placeholder: {
                                ProgressView().tint(.white)
                            }
                            .frame(width: 110, height: 110)
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 110, height: 110)
                                .foregroundStyle(.gray)
                        }
                        
                        // Bio & Bouton
                        VStack(alignment: .center, spacing: 12) {
                            if isEditing {
                                TextEditor(text: $bioText)
                                    .frame(height: 90)
                                    .scrollContentBackground(.hidden)
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(8)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 13))
                            } else {
                                Text(bioText)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14))
                                    .lineLimit(6)
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            Button {
                                withAnimation {
                                    isEditing.toggle()
                                }
                            } label: {
                                BasicButton(text: isEditing ? "Enregistrer" : "Modifier")
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Divider()
                        .background(Color.white.opacity(0.2))
                        .padding(.horizontal)
                    
                    NavigationLink {
                        PlaylistsView(user: $userConnected)
                    } label: {
                        IconButton(
                            text: "Mes Playlists",
                            icon: "book.pages.fill"
                        )
                    }
                    
                    MyFavoris(user: self.$userConnected)
                        .padding(.top, -10)
                    
                    Spacer()
                }
            }
            .task {
                // Cascade fetch for Series
                if let seriesIDs = userConnected.favoriteSerieIDs {
                    for id in seriesIDs {
                        if let s = try? await vmSerie.getSerieById(id) {
                            if !userConnected.favoriteSeries.contains(where: {
                                $0?.name == s.name
                            }) {
                                userConnected.favoriteSeries.append(s)
                            }
                        }
                    }
                }

                if let actorIDs = userConnected.favoriteActorIDs {
                    for id in actorIDs {
                        if let a = try? await vmSerie.getActorById(id) {
                            if !userConnected.favoriteActors.contains(where: {
                                $0?.name == a.name
                            }) {
                                userConnected.favoriteActors.append(a)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MyProfile(userConnected: MockData.magalie)
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(PlayListViewModel())
        .environment(ActorViewModel())
}
