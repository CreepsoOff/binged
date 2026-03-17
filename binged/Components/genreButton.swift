//
//  genreButton.swift
//  binged
//
//  Created by Apprenant 92 on 10/03/2026.
//

import SwiftUI

struct genreButton: View {
    var genre: String
    
    var body: some View {
        Text(genre)
            .padding(12)
            .background(.background1)
            .cornerRadius(20)
            .foregroundColor(.white)
    }
}

#Preview {
    genreButton(genre: "Action")
}
