//
//  searchSerie.swift
//  binged
//
//  Created by Apprenant 92 on 16/03/2026.
//

import SwiftUI

struct searchSerie: View {
    @State private var searchSerie = ""
    
    var user: User
    
//    var filteredSeries: [Serie] {
//        if searchSerie.isEmpty {
//            return user.favoriteSerie
//        }
//        return user.favoriteSerie.filter {
//            $0.name.localizedCaseInsensitiveContains(searchSerie)
//        }
//    }
    
    var body: some View {
        searchBar(text: $searchSerie)
//        ForEach(filteredSeries, id: \.id) { serie in
//            genreButton(genre: serie.name)
//        }
    }
}

#Preview {
    searchSerie(user: MockData.magalie)
}
