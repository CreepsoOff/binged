//
//  PlaylistBar.swift
//  binged
//
//  Created by Apprenant 105 on 17/03/2026.
//

import SwiftUI

struct PlaylistBar: View {
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
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

#Preview {
    PlaylistBar()
}
