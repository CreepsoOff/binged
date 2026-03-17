//
//  MyProfile.swift
//  binged
//
//  Created by Apprenant 92 on 06/03/2026.
//

import SwiftUI

struct MyProfile: View {
    @State var vmUser = UserViewModel()
    @State var userConnected: User
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                Text("Mon Profil")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                HStack {
                    Image("pitt")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .padding()
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
    MyProfile(userConnected: MockData.magalie)
}
