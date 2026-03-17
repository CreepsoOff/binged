//
//  searchGenre.swift
//  binged
//
//  Created by Apprenant 92 on 13/03/2026.
//

import SwiftUI

struct searchGenre: View {
    @State private var searchGenre = ""
    var user: User
    
    var filteredGenres: [Genre] {
            if searchGenre.isEmpty {
                return user.favoriteGenre
            }
            return user.favoriteGenre.filter {
                $0.rawValue.localizedCaseInsensitiveContains(searchGenre)
            }
        }
    
    var body: some View {
        searchBar(text: $searchGenre)
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(filteredGenres, id: \.rawValue) { genre in
                    genreButton(genre: genre.rawValue)
                }
            }
        }
        Text("a modifier")
    }
}

#Preview {
    searchGenre(user: magalie)
}
