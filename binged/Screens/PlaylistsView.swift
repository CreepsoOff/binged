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
                        HStack {
                            Text("Favories")
                                .foregroundStyle(.white)
                                .font(.system(size: 24))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 10)
                            SFButton(icon: "plus")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PlaylistsView(user: MockData.magalie)
}
