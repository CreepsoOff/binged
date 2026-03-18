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
    var allSeries: [Serie]
    
    var filteredSeries: [Serie] {
        let favorites = user.favoriteSerie(allSeries: allSeries)
                
                if searchSerie.isEmpty {
                    return favorites
                }
        return favorites.filter {
                    $0.name.localizedCaseInsensitiveContains(searchSerie)
                }
            }
        
    
    var body: some View {
        VStack(alignment: .leading) {
                    searchBar(text: $searchSerie)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(filteredSeries) { serie in
                                basicButton(Serie: serie.name)
                            }
            }
        }
//    var filteredSeries: [Serie] {
//        if searchSerie.isEmpty {
//            return user.favoriteSerie
//        }
//        return user.favoriteSerie.filter {
//            $0.name.localizedCaseInsensitiveContains(searchSerie)
//        }
//    }
    
//    var body: some View {
//        searchBar(text: $searchSerie)
////        ForEach(filteredSeries, id: \.id) { serie in
////            SerieButton(Serie: serie.name)
////        }
//    }
}

#Preview {
    searchSerie(user: magalie)
}
