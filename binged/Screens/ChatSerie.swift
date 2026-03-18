//
//  ChatSerie.swift
//  binged
//
//  Created by Apprenant 92 on 12/03/2026.
//

import SwiftUI

struct ChatSerie: View {
    var body: some View {
        ZStack{
            Color("background")
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10){
                
                Text("Arcane")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                ZStack{
                    Image("arcane_cover")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 800, height: 700)
                        .clipped()
                        .opacity(0.4)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ChatSerie()
}
