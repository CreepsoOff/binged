//
//  SearchSerie.swift
//  binged
//
//  Created by Apprenant 92 on 16/03/2026.
//

import SwiftUI

struct SearchSerie: View {
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
        SearchBar(text: $searchSerie)
//        ForEach(filteredSeries, id: \.id) { serie in
//            GenreButton(genre: serie.name)
//        }
    }
}

#Preview {
    SearchSerie(user: MockData.magalie)
}
