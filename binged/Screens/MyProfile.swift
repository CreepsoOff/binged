//
//  MyProfile.swift
//  binged
//
//  Created by Apprenant 92 on 06/03/2026.
//

import SwiftUI

struct MyProfile: View {
    @Environment(UserViewModel.self) private var vmUser
    @Environment(SerieViewModels.self) private var vmSerie
    @State var userConnected: User

    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                VStack {
                    Text("Mon Profil")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                    HStack {
                        if let url = userConnected.picture?.first?.thumbnails?
                            .large?.url
                        {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .padding()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 200, height: 100)

                        } else {
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: 100))
                        }

                        VStack {
                            Text(
                                "Acteur et producteur américain célèbre pour Fight Club, Seven et Once Upon a Time in Hollywood. Il a remporté plusieurs Oscars."
                            )
                            .foregroundStyle(.white)
                            .lineLimit(8)
                            BasicButton(text: "Modifier")
                        }
                    }
                    MyFavoris(user: self.$userConnected)
                        .padding()

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
