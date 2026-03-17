//
//  PlaylistsView.swift
//  binged
//
//  Created by Apprenant 105 on 17/03/2026.
//

import SwiftUI

struct PlaylistsView: View {
    
    var user: User
    
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
                        Image(user.picture!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .padding(5)
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
                        HStack {
                            Text("Favories")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 10)
                            sfButton(icon: "plus")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PlaylistsView(user: colette)
}
