//
//  searchActor.swift
//  binged
//
//  Created by Apprenant 92 on 16/03/2026.
//

import SwiftUI

struct SearchActorView: View {
    @State private var searchText = ""
    @State var vmActor = ActorViewModel()
    
    @State private var listActors: [CastMember] = []
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var user: User
    
    var filteredActors: [CastMember] {
        if searchText.isEmpty {
            return listActors
        }
        return listActors.filter { actor in
            actor.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        VStack {
            searchBar(text: $searchText)
            
            ScrollView(showsIndicators: false) {
                // Utilise \.id (le UUID) pour éviter les problèmes si deux acteurs ont le même nom
                LazyVGrid(columns: columns, spacing: 20){
                    ForEach(filteredActors, id: \.id) { actor in
                        actorBar(actor: actor)
                    }
                }
            }
        }
        .task {
            // 1. On synchronise d'abord avec les données locales du User
            self.listActors = user.favoriteActorsSafe
            
            // 2. Si la liste est vide mais qu'on a des IDs, on charge le reste
            if self.listActors.isEmpty, let ids = user.favoriteActorIDs {
                for actorID in ids {
                    do {
                        let fetchedActor = try await vmActor.getActorById(actorID)
                        // On vérifie qu'on ne l'ajoute pas deux fois
                        if !listActors.contains(where: { $0.id == fetchedActor.id }) {
                            self.listActors.append(fetchedActor)
                        }
                    } catch {
                        print("Erreur Airtable Actor: \(error)")
                    }
                }
            }
        }
    }
}

#Preview {
    SearchActorView(user: MockData.magalie)
}
