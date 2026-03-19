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
            Color("background")
                .ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        Text(user.firstName!)
                            .foregroundStyle(.white)
                            .font(.system(size: 32))
                            .bold()
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
                        }//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 50, height: 50)
//                            .clipShape(Circle())
//                            .padding(5)
                    }
                    .padding()
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Playlits")
                                .foregroundStyle(.white)
                                .font(.system(size: 40))
                                .bold()
                                .padding(.horizontal, 10)
                                Spacer()
                        }
                    }
                    ScrollView {
                        if !listPl.isEmpty {
                            ForEach(listPl) { playlist in
                                PlaylistBar(playlist: playlist)
                            }
                        }
                    }
                }
            }
        }.task {
            if let playlistIDs = user.playlistIDs {
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
                        
                        self.listPl.append(p)
                    } catch {
                    }
                }
            }
        }
    }
}

#Preview {
    PlaylistsView(user: .constant(MockData.magalie))
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(PlayListViewModel())
}
