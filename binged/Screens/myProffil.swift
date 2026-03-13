//
//  myProffil.swift
//  binged
//
//  Created by Apprenant 92 on 06/03/2026.
//

import SwiftUI

struct myProffil: View {
    @State private var searchActor = ""
    var user: User
    
    var filteredActors: [Actor] {
        if searchActor.isEmpty {
            return user.favoriteActor
        }
        return actors.filter {
            $0.actorFirstName.localizedCaseInsensitiveContains(searchActor)
        }
    }
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                Text("Mon Proffil")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                HStack {
                    Image("pitt")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .padding()
                    VStack {
                        Text(
                            "Acteur et producteur américain célèbre pour Fight Club, Seven et Once Upon a Time in Hollywood. Il a remporté plusieurs Oscars."
                        )
                        .foregroundColor(.white)
                        .lineLimit(8)
                        basicButton(text: "Modifier")
                    }
                }
                HStack {
                    Text("Mes Favoris")
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                    basicButton(text: "Modifier")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Text("Genres")
                    .foregroundColor(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        genreButton(genre: "Action")
                        genreButton(genre: "Policier")
                        genreButton(genre: "SF")
                        genreButton(genre: "Policier")
                        genreButton(genre: "Policier")
                        genreButton(genre: "Policier")
                        genreButton(genre: "Policier")
                    }
                }
                Text("Acteurs")
                    .foregroundColor(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
//                        ForEach(actors) { actor in
//                            actorBar(actor: actor)
//                        }
                    }
                }
                Text("Série")
                    .foregroundColor(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
            }
        }
    }
}

#Preview {
    myProffil(user: magalie)
}
