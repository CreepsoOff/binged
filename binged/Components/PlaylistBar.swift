//
//  PlaylistBar.swift
//  binged
//
//  Created by Apprenant 105 on 17/03/2026.
//

import SwiftUI

struct PlaylistBar: View {
    
    //    var user: User
    //    var serie: [Serie]
    @State private var isAdd = false
    var playlist: Playlist
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text(playlist.name)
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    Button(action: {
                        isAdd.toggle()
                    }) {
                        Image(systemName: isAdd ? "minus" : "plus")
                            .padding(isAdd ? 14 : 8)
                            .background(.orange)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .clipShape(.circle)
                            .frame(width: 24, height: 24)
                            .padding(.horizontal)
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(MockData.colette.favoriteSeriesSafe) { serie in
                            Image(serie.cover!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 150)
                                .clipped()
                                .padding(.horizontal, 4)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}


