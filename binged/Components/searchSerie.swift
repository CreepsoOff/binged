//
//  searchSerie.swift
//  binged
//
//  Created by Apprenant 92 on 16/03/2026.
//
//
//import SwiftUI
//
//struct searchSerie: View {
//    @State private var searchSerie = ""    
//    var user: User
//    var allSeries: [Serie]
//    
//    var filteredSeries: [Serie] {
//        let favorites = user.favoriteSerie(allSeries: allSeries)
//
//                if searchSerie.isEmpty {
//                    return favorites
//                }
//        return favorites.filter {
//                    $0.name.localizedCaseInsensitiveContains(searchSerie)
//                }
//            }
//        
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//                    searchBar(text: $searchSerie)
//                    
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack {
//                            ForEach(filteredSeries) { serie in
//                                basicButton(Serie: serie.name)
//                            }
//            }
//        }
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
//}
//
//#Preview {
//    searchSerie(user: MockData.magalie)
//}
//
//  searchSerie.swift
//  binged
//
//  Created by Apprenant 92 on 16/03/2026.
//

import SwiftUI

struct SearchSerie: View {
    // On renomme la variable d'état pour éviter le conflit avec le nom de la struct
    @State private var searchText = ""
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var user: User
    
    var filteredSeries: [Serie] {
        if searchText.isEmpty {
            // On utilise la nouvelle variable calculée 'favoriteGenres'
            return user.favoriteSeriesSafe
        }
        return user.favoriteSeriesSafe.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        VStack { // J'ai ajouté un VStack pour bien séparer la searchBar du ScrollView
            searchBar(text: $searchText) // Modifié ici
            
            ScrollView(showsIndicators: false) {
                HStack {
                    LazyVGrid(columns: columns, spacing: 20){
                    // id: \.self est plus adapté pour un Enum
                        ForEach(filteredSeries) { serie in
                            if let cover = serie.cover {
                                VStack{
                                    Image(cover)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 150)
                                        .clipped()
                                        .padding(.horizontal, 4)
                                    Text(serie.name)
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal) // Un peu de padding pour faire respirer la liste
            }
        }
    }
}

#Preview {
    SearchSerie(user: MockData.magalie)
}
