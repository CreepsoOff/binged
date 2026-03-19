//
//  PlaylistsView.swift
//  binged
//
//  Created by Apprenant 105 on 17/03/2026.
//

import SwiftUI

struct PlaylistsView: View {
    
    @Binding var user: User
    @State var vmplaylist = PlayListViewModel()
    @State var listPl : [Playlist] = []
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        Text(user.firstName!)
                            .foregroundColor(.white)
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
                                .foregroundColor(.white)
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
                        let p = try await vmplaylist.getPlayListById(plid)
                        self.listPl.append(p)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    PlaylistsView(user: .constant(MockData.magalie))
}
