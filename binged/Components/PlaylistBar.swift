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
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("Favories")
                        .foregroundStyle(.white)
                        .font(.system(size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    Button(action: {
                        isAdd.toggle()
                    }) {
                        Image(systemName: isAdd ? "minus" : "plus")
                            .accessibilityLabel(isAdd ? "Remove from playlist" : "Add to playlist")
                            .padding(isAdd ? 14 : 8)
                            .background(.orange)
                            .clipShape(.rect(cornerRadius: 20))
                            .foregroundStyle(.white)
                            .clipShape(.circle)
                            .frame(width: 24, height: 24)
                            .padding(.horizontal)
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(MockData.colette.favoriteSeriesSafe) { serie in
                            Image("the_boys_cover")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 85, height: 110)
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

#Preview {
    PlaylistBar()
}
