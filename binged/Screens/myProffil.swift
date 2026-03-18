//
//  myProffil.swift
//  binged
//
//  Created by Apprenant 92 on 06/03/2026.
//

import SwiftUI

struct myProffil: View {
    @State var vmUser = UserViewModel()
    @State var userConnected: User
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                Text("Mon Profil")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                HStack {
                    if let url = userConnected.picture?.first?.thumbnails?.large?.url {
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
                    VStack {
                        Text(
                            "Acteur et producteur américain célèbre pour Fight Club, Seven et Once Upon a Time in Hollywood. Il a remporté plusieurs Oscars."
                        )
                        .foregroundColor(.white)
                        .lineLimit(8)
                        basicButton(text: "Modifier")
                    }
                }
                myFavoris(user: self.$userConnected)
                    .padding()

            }
        }.task {
            do {
                self.userConnected = try await vmUser.getUserById("rec279AxVMVJ5GrPQ")
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    myProffil(userConnected: MockData.magalie)
}
