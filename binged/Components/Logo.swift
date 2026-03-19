//
//  logo.swift
//  binged
//
//  Created by Apprenant 92 on 11/03/2026.
//

import SwiftUI

struct Logo: View {
    var icon: String
    
    var body: some View {
        Image(icon)
        .resizable()
        .scaledToFill()
        .frame(width: 32, height: 32)
        .clipShape(Circle())
//        .shadow(
//            radius: 3,
//            x: 5,
//            y: 5
//        )
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(.white, lineWidth: 1)
        )
    }
}

#Preview {
    Logo(icon: "netflix_icon")
}
