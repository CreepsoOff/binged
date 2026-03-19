//
//  PlaylistsView.swift
//  binged
//
//  Created by Apprenant 105 on 17/03/2026.
//

import SwiftUI

struct PlaylistsView: View {
    
    @Binding var user: User
    @Environment(PlayListViewModel.self) private var vmplaylist
    @Environment(SerieViewModels.self) private var vmSerie
    @State var listPl : [Playlist] = []
    
    var body: some View {
        ZStack {
            Design.bgColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Utilisateur
                HStack(spacing: 15) {
                    if let url = user.picture?.first?.thumbnails?.large?.url {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(.gray)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(user.firstName ?? "Utilisateur")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .bold()
                        Text("Vos sélections")
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                    }
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Playlists")
                        .foregroundStyle(.white)
                        .font(.system(size: 40))
                        .bold()
                        .padding(.horizontal)
                }
                
                ScrollView {
                    VStack(spacing: 25) {
                        if listPl.isEmpty {
                            VStack(spacing: 10) {
                                ProgressView()
                                    .tint(.orange)
                                Text("Chargement de vos playlists...")
                                    .foregroundStyle(.gray)
                            }
                            .padding(.top, 50)
                        } else {
                            ForEach(listPl) { playlist in
                                PlaylistBar(playlist: playlist)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
        }
        .task {
            if let playlistIDs = user.playlistIDs {
                var fetchedPlaylists: [Playlist] = []
                for plid in playlistIDs {
                    do {
                        var p = try await vmplaylist.getPlayListById(plid)
                        
                        if let sIDs = p.serieIDs {
                            for sid in sIDs {
                                if let s = try? await vmSerie.getSerieById(sid) {
                                    if p.series == nil { p.series = [] }
                                    if !(p.series?.contains(where: { $0.id == s.id }) ?? false) {
                                        p.series?.append(s)
                                    }
                                }
                            }
                        }
                        fetchedPlaylists.append(p)
                    } catch {
                        print("Erreur fetch playlist \(plid): \(error)")
                    }
                }
                self.listPl = fetchedPlaylists
            }
        }
    }
}

#Preview {
    NavigationStack {
        PlaylistsView(user: .constant(MockData.magalie))
            .environment(SerieViewModels())
            .environment(UserViewModel())
            .environment(PlayListViewModel())
    }
}
