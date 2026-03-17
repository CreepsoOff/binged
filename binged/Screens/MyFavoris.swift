//
//  MyFavoris.swift
//  binged
//
//  Created by Apprenant 92 on 11/03/2026.
//

import SwiftUI

struct MyFavoris: View {
    @State private var selectedScreen = 0
    
    @Binding var user: User

    var body: some View {
        ZStack{
            Color("background")
                .ignoresSafeArea()
            VStack{
                Picker("Vos favoris", selection: $selectedScreen) {
                    Text("Genre").tag(0)
                    Text("Actor").tag(1)
                    Text("Serie").tag(2)
                }.pickerStyle(.segmented)
                switch selectedScreen {
                case 1:
                    SearchActorView(user: user)
                case 2:
                    SearchSerie(user: user)
                default:
                SearchGenre(user: user)
                }
                Spacer()
            }
        }
    }
}
    
#Preview {
    MyFavoris(user: .constant(MockData.magalie))
}
